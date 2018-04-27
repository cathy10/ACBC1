%Import csv file into table format
acbc_data  = readtable('GNG2DATA.csv');

%STEP 1: Create a dictionary that is specific to this respondent, called
%'resp_id'
profile_id = acbc_data(:,'PROFILEID'); %grab profile ID column from input data
profileFirst = profile_id{1,1};
resp_dict = makeDictionary(profileFirst); %make a dictionary of profile and attributes

%STEP 2: Update respondent's ID with Revisions

%STEP 2a: Make temporary dictionary for revisions
revisions_id = acbc_data(:,'revise1'); %grab revisions data from original data
reviseFirst = revisions_id{1,1};
revisions_dict = makeDictionary(reviseFirst); %make a dictionary

%STEP 2b: Outer join the current respondent dictionary with temporary
%dictionary

updated_dict = outerjoin(resp_dict,revisions_dict,'Keys','Profile','MergeKeys',true)

%STEP 3: Count Appearance from this respondent's ID
%STEP 4: Change current respondent's ID with Universal ID 
%STEP 5: Update Universal Dictionary with this respondent's Dictionary
%STEP 6: Revise Output 

%{
Helper function that cleans profile ID data from its original messy format.
Used mainly for profile ID and revision ID. 

ARGUMENTS:

INPUT:
@messy_array: input array, has to be cleaned
@respondent_num: the ID number of the respondent that is being cleaned

OUTPUT
@dict: cleaned output array. From one string representing all profiles to
distinct array elements with a string of profile with its attributes.

e.g.
From '[[1,2,3,4],[5,6,7,8]]'
to array(1): '1,2,3,4' array(2): '5,6,7,8'
%}
function cleaned_array = cleanIDData(messy_array)
    messy_array = cell2mat(messy_array); %changes from table to matrix, grab 1st respondent data

    cleaned_array = strsplit(messy_array,'],['); %split string into an array of profile
                                   %ID with attributes (e.g. [1,5,2,1,3])
    n = length(cleaned_array); %length of data                                  
    %Clean data: remove brackets from first and last data points
    cleaned_array(1) = strrep(cleaned_array(1),'[','');
    cleaned_array(n) = strrep(cleaned_array(n),']','');
end


%{
Helper function that builds a dictionary of profile with its attributes
 depending from a given array of profiles, with its ID and attributes.

ARGUMENTS:

INPUT:
@profile_array: input array, has to be cleaned

OUTPUT
@dict: output table, which is a dictionary of profiles and attributes
%}
function dict = makeDictionary(profile_array)
    %clean data first
    profile_array = cleanIDData(profile_array);
    
    n = length(profile_array);%length of input array
    
    %Create empty dictionary (MATLAB table) for current respondent
    dict = cell2table(cell(n,2));
    headers = {'Profile','Attributes'}; %set headers
    dict.Properties.VariableNames = headers;
    
    %loop over each profile in respondent's ID
    for i = 1:n 
        profileVector = strsplit(cell2mat(profile_array(i)),','); %split profile to array of numbers (e.g. 1,4,2,1,3 to 1 4 2 1 3 -> array)
        dict(i,1).Profile = {(cell2mat(profileVector(1)))}; %extracted profile ID, insert to dictionary
        dict(i,2).Attributes = {str2num(strjoin(profileVector(2:end),''))}; %extracted attributes ID, combined together (e.g. 2,3,1 to 231) for computation purposes, then add to dictionary
    end
end
