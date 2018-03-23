function windata=winners(Respondent,data,numAtt,numProfiles)
 for profile=2:2:numProfiles
    for i=1:numAtt
     windata(3*(profile/2-1)+i,1)=data(3*(profile-2)+i,data(3*(profile-2)+1,3));
     windata(3*(profile/2-1)+i,2)=data(3*(profile-1)+i,data(3*(profile-1)+1,3));       
    end
    for i=1:2  %%compute score for ith profile
     score(1,i)=Respondent.partworth(1,windata(3*(profile/2-1)+1,i))+Respondent.partworth(2,windata(3*(profile/2-1)+2,i))+Respondent.partworth(3,windata(3*(profile/2-1)+3,i));
    end
     [~,windata(3*(profile/2-1)+1,3)]=max(score);
 end 
end


 