%% Profile 1 and Profile 2 are 3x13 matrices giving the par 

function correct=predict(profile1,profile2,partworth,theta,trial)
correct=0
for i=1:length(profile1(:,1))
  s1(1,1)=partworth(1,profile1(1,1))+partworth(2,profile1(2,1))+partworth(3,profile1(3,1));
  s2(1,1)=partworth(1,profile2(1,1))+partworth(2,profile2(2,1))+partworth(3,profile2(3,1));
  s1(2,1)=theta(1,profile1(1,1),trial)+theta(2,profile1(2,1),trial)+theta(3,profile1(3,1),trial);
  s2(2,1)=theta(1,profile2(1,1),trial)+theta(2,profile2(2,1),trial)+theta(3,profile2(3,1),trial);
  if s1(1,1)>s2(1,1) & s1(2,1)>s2(2,1)
    correct=correct+1;
  end
end
end