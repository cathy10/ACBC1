classdef populationAttribute
    properties
    Mean
    Sd
    end
     methods
         function sampleLevel = sample(obj)  %% 
            sampleLevel=normrnd(obj.Mean, obj.Sd);
        end
    end
end