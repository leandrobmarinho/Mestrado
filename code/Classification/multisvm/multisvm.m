function [labels, times, outputs] = multisvm(TrainingSet,GroupTrain,TestSet, conf)
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

tic
%build models
for k=1:numClasses
    %Vectorized statement that binarizes Group
    %where 1 is the current class and 0 is all other classes
    G1vAll=(GroupTrain==u(k));
%     models(k) = svmtrain(TrainingSet,G1vAll);
        
    if (strcmp('rbf', conf.fkernel) == 1)
%         models(k) = svmtrain(TrainingSet, G1vAll,'kernel_function',...
%             conf.fkernel, 'rbf_sigma', conf.sigma,'boxconstraint', conf.paraC,...
%             'method', conf.metodo,'kernelcachelimit',kernelcachelimit,'Options', conf.options);
        
        models(k) = svmtrain(TrainingSet, G1vAll,'kernel_function',...
            conf.fkernel, 'rbf_sigma', conf.sigma,'boxconstraint', conf.paraC,...
            'method', conf.metodo,'kernelcachelimit',15000,'Options', conf.options);
    else
%         models(k) = svmtrain(TrainingSet, G1vAll,'kernel_function',...
%             conf.fkernel,'boxconstraint',conf.paraC,'method',conf.metodo,...
%             'kernelcachelimit',kernelcachelimit,'Options', conf.options);
        
        models(k) = svmtrain(TrainingSet, G1vAll,'kernel_function',...
            conf.fkernel,'boxconstraint',conf.paraC,'method',conf.metodo,...
            'kernelcachelimit',15000,'Options', conf.options);
    end
end
times.trein = toc;

% for j=1:size(TestSet,1)
%     for k=1:numClasses
%         if(svmclassify2(models(k),TestSet(j,:)))
%             break;
%         end
%     end
%     result(j) = k;
% end
% result

%classify test cases
tic
labels = []; outputs = [];
for k=1:numClasses
    [l, o] = svmclassify2(models(k), TestSet);
    labels = [labels l];
    outputs = [outputs o];
end
times.test = toc;
[~, labels] = max(labels');
outputs = sign(outputs);
