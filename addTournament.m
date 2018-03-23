function [masterProfiles, winners0,winners1,winners2,winners3]=addTournament(surveyfile, respondent, n,NA, masterProfiles)

%% Determine Winning Profiles
   winners0=xlsread(strcat('temp2',surveyfile),num2str(n),'A1:C24');
   winners1=winners(respondent,winners0,NA,8);  %% quarters
   winners2=winners(respondent,winners1,NA,4);  %% semis
   winners3=winners(respondent,winners2,NA,2);  %% championship
%% Update masterProfiles
%% Add/update BYO masterProfiles
  numProfiles=length(masterProfiles(1,:)/3);
   [LIA,LIB]=ismember(transpose(respondent.BYO),transpose(masterProfiles(1:3,:)),'rows'); 
   if LIA ~= 1
        masterProfiles=[masterProfiles [respondent.BYO;64]];      
     else
        masterProfiles(4,LIB)=masterProfiles(4,LIB)+64;
   end      
%% Add/update Tournament Profiles
%%% Final Winner Gets 16 Points  Runner Up Gets 8 points
         for k=1:2
         contestant=winners3(:,k);
         [LIA,LIB]=ismember(transpose(contestant),transpose(masterProfiles(1:3,:)),'rows');               
           if LIA ~= 1 &  winners3(1,3)==k
            numProfiles=length(masterProfiles(1,:)/3);
           masterProfiles=[masterProfiles [contestant;16]];
           end
           if LIA ~= 1 &  winners3(1,3)~=k
            numProfiles=length(masterProfiles(1,:)/3);
            masterProfiles=[masterProfiles [contestant;8]];
            end
           if LIA ==1  &  winners3(1,3)==k
              masterProfiles(4,LIB)= masterProfiles(4,LIB)+16;
           end
           if LIA == 1 &  winners3(1,3)~=k
             masterProfiles(4,LIB)= masterProfiles(4,LIB)+8;
            end
         end  

        %%% Semi-Finalists Get 4 Points
    for j=1:2
        for k=1:2
         contestant=[winners2(3*(j-1)+1,k); winners2(3*(j-1)+2,k); winners2(3*(j-1)+3,k)];
         [LIA,LIB]=ismember(transpose(contestant),transpose(masterProfiles(1:3,:)),'rows');               
           if LIA ~= 1 
            numProfiles=length(masterProfiles(1,:)/3);
            masterProfiles=[masterProfiles [contestant;4]];
            else
            masterProfiles(4,LIB)=masterProfiles(4,LIB)+4;           
           end              
        end               
    end  
    
        %%% Quarter Finalists Get 2 Points
    for j=1:4
        for k=1:2
         contestant=[winners1(3*(j-1)+1,k); winners1(3*(j-1)+2,k); winners1(3*(j-1)+3,k)];
         [LIA,LIB]=ismember(transpose(contestant),transpose(masterProfiles(1:3,:)),'rows');               
           if LIA ~= 1 
            numProfiles=length(masterProfiles(1,:)/3);
             masterProfiles=[masterProfiles [contestant;2]];
           else
            masterProfiles(4,LIB)=masterProfiles(4,LIB)+2;           
           end              
        end               
    end  
    
         %%% Qualifiers Get 1 Points
    for j=1:8
        for k=1:2
         contestant=[winners0(3*(j-1)+1,k); winners0(3*(j-1)+2,k); winners0(3*(j-1)+3,k)];
         [LIA,LIB]=ismember(transpose(contestant),transpose(masterProfiles(1:3,:)),'rows');               
           if LIA ~= 1 
            numProfiles=length(masterProfiles(1,:)/3);
            masterProfiles=[masterProfiles [contestant;1]];
           else
            masterProfiles(4,LIB)=masterProfiles(4,LIB)+1;           
           end              
        end               
    end   

 %% CREATE OUTPUT DATAFILE
 %% Partworth Data
  xlswrite(surveyfile, {'PARTWORTH'},num2str(n),'A1');
  xlswrite(surveyfile, {'Attribute'},num2str(n),'A2');
  xlswrite(surveyfile, 1,num2str(n),'A3');
  xlswrite(surveyfile, 2,num2str(n),'A4');
  xlswrite(surveyfile, 3,num2str(n),'A5');
  xlswrite(surveyfile, {'Level:'},num2str(n),'B2');
  xlswrite(surveyfile, 1,num2str(n),'C2');
  xlswrite(surveyfile, 2,num2str(n),'D2');
  xlswrite(surveyfile, 3,num2str(n),'E2');
  xlswrite(surveyfile, 4,num2str(n),'F2');
  xlswrite(surveyfile, 5,num2str(n),'G2');
  xlswrite(surveyfile, respondent.partworth,num2str(n),'C3:G5'); 
  xlswrite(surveyfile, {'Must Have'},num2str(n),'I2'); 
  xlswrite(surveyfile, respondent.musthave,num2str(n),'I3'); 
  xlswrite(surveyfile, {'Revealed'},num2str(n),'J2'); 
  xlswrite(surveyfile, respondent.revealedMusthave,num2str(n),'J3'); 
  xlswrite(surveyfile, {'Totally Unacceptable'},num2str(n),'K2'); 
  xlswrite(surveyfile, respondent.unaccept,num2str(n),'K3'); 
  xlswrite(surveyfile, {'Revealed'},num2str(n),'L2'); 
  xlswrite(surveyfile, respondent.revealedUnaccept,num2str(n),'L3'); 
 %% BYO
  xlswrite(surveyfile, {'BYO'},num2str(n),'H2');
  xlswrite(surveyfile, respondent.BYO,num2str(n),'H3'); 
 %% Screening
 xlswrite(surveyfile, {'SCREENING'},num2str(n),'A7');
  xlswrite(surveyfile, {'possible=1'},num2str(n),'F7');
 xlswrite(surveyfile, {'Profile1'},num2str(n),'A8');
 xlswrite(surveyfile, {'Profile2'},num2str(n),'B8');
 xlswrite(surveyfile, {'Profile3'},num2str(n),'C8');
 xlswrite(surveyfile, {'Best Profi'},num2str(n),'D8');
 xlswrite(surveyfile, {'Utility'},num2str(n),'E8');
 xlswrite(surveyfile, {'Profile1'},num2str(n),'F8');
 xlswrite(surveyfile, {'Profile2'},num2str(n),'G8');
 xlswrite(surveyfile, {'Profile3'},num2str(n),'H8');
 xlswrite(surveyfile,respondent.surveydata,num2str(n),'A9:H23');
 %% TOURNAMENT
 xlswrite(surveyfile, {'TOURNAMENT'},num2str(n),'A25'); 
 xlswrite(surveyfile, {'Qualifiers'},num2str(n),'A26');
 xlswrite(surveyfile, winners0,num2str(n),'A27:C50');
 xlswrite(surveyfile, {'Quarters'},num2str(n),'E26');
 xlswrite(surveyfile, winners1,num2str(n),'E27:G38');
 xlswrite(surveyfile, {'Semis'},num2str(n),'I26');
 xlswrite(surveyfile, winners2,num2str(n),'I27:K32');
 xlswrite(surveyfile, {'Finals'},num2str(n),'M26');
 xlswrite(surveyfile, winners3,num2str(n),'M27:O29');
end  
   


