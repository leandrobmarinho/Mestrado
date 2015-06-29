clear all; close all; clc;

load fisheriris

X = meas;
% Extract the Setosa class
Y = nominal(ismember(species,'setosa'));

ptreino = 0.8;
fkernel = 'linear';
sigma = 14;
paraC = ceil(0.1 * ptreino * size(X,1));

% Randomly partitions observations into a training set and a test
% set using stratified holdout
P = cvpartition(Y,'Holdout',0.20);

svmStruct = svmtrain(X(P.training,:),Y(P.training),'kernel_function',...
    fkernel,'rbf_sigma',sigma,'boxconstraint',paraC,...
    'method','QP','kernelcachelimit',15000);

% C = svmclassify(svmStruct,X(P.test,:));
% err_rate = sum(Y(P.test)~= C)/P.TestSize; % mis-classification rate
% conMat = confusionmat(Y(P.test),C); % the confusion matrix

[classificacao, saida_real] = svmclassify2(svmStruct,X(P.test,:));
acc = sum(Y(P.test)== classificacao)/P.TestSize
confusionmat(Y(P.test), classificacao)