function [labels, times, outputs, accModels] = multisvm(TrainingSet,GroupTrain,TestSet, conf)
%Models a given training set with a corresponding group vector and
%classifies a given test set using an SVM classifier according to a
%one vs. all relation.
%
%This code was written by Cody Neuburger cneuburg@fau.edu
%Florida Atlantic University, Florida USA
%This code was adapted and cleaned from Anand Mishra's multisvm function
%found at http://www.mathworks.com/matlabcentral/fileexchange/33170-multi-class-support-vector-machine/

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
    times.trein = toc;
    
catch ME
    labels      = nan(1,size(TestSet,1));
    times.trein = nan;
    times.test  = nan;
    outputs     = nan(size(TestSet,1),numClasses);
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


% tic
% for j=1:size(TestSet,1)
%     for k=1:numClasses
%         if(svmclassify2(models(k),TestSet(j,:)))
%             break;
%         end
%     end
%     labels(j) = k;
% end
% times.test = toc;


%classify test cases
tic
labels = []; outputs = [];
for k=1:numClasses
    [~, o] = svmclassify2(models(k), TestSet);
%     labels = [labels l];
    outputs = [outputs o];
end
times.test = toc;
[~, inds] = sort(outputs', 'ascend');
labels = inds(1,:);
%[~, labels] = max(labels');
%outputs = sign(outputs);
