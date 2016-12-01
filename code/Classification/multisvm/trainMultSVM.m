function [ models, time, accModels ] = trainMultSVM( TrainingSet, GroupTrain, conf )
%TRAINMULTSVM Summary of this function goes here
%   Detailed explanation goes here


u=unique(GroupTrain);
numClasses=length(u);
% labels = zeros(length(TestSet(:,1)),1);

% kernelcachelimit = size(TrainingSet,1) + 50;


try
    tic
    %build models
    for k=1:numClasses
        %Vectorized statement that binarizes Group
        %where 1 is the current class and 0 is all other classes
        G1vAll = (GroupTrain==u(k));
        
        if (strcmp('rbf', conf.fkernel) == 1)
            
            models(k) = svmtrain(TrainingSet, G1vAll,'kernel_function',...
                conf.fkernel, 'rbf_sigma', conf.sigma,'boxconstraint', conf.paraC,...
                'method', conf.metodo,'kernelcachelimit',15000,'Options', conf.options);
        else
            
            models(k) = svmtrain(TrainingSet, G1vAll,'kernel_function',...
                conf.fkernel,'boxconstraint',conf.paraC,'method',conf.metodo,...
                'kernelcachelimit',15000,'Options', conf.options);
        end
    end
    time = toc;
    
catch ME
    time = nan;
    accModels = zeros(1,numClasses);

    sprintf('Erro no treinamento do (LS)SVM!')
    return
end


%% Train ACC to SDL
accModels = zeros(1,numClasses);
numTrain = length(GroupTrain);
for k=1:numClasses    
    G1vAll = (GroupTrain==u(k));

    [l, ~] = svmclassify2(models(k), TrainingSet);
    accModels(k) = sum(G1vAll == l)/numTrain;
end

end

