function [ results ] = MLM(dataset, distance, param, nFolds, NN)
option = 'distances';
type = 'knn';
% nFolds = 10;

% param = 0.1:0.1:1;
bias = 0;
lambda = 0; %10e-10;


keyboard
[dadosTrein, dadosTeste] = embaralhaDados(dataset, 0.8, 2);

%% metodologia basica
% data.x = dataset.xtrain;
% data.y = dataset.ytrain;

[opt_parameter, Ecv] = optimize_MLM(dadosTrein, param, bias, lambda, type, nFolds, option, distance, NN);

K = round(opt_parameter*size(dadosTrein.x, 1));
ind = randperm(size(dadosTrein.x,1));
refPoints.x = dadosTrein.x(ind(1:K), :);
refPoints.y = dadosTrein.y(ind(1:K), :);

[model] = train_MLM(refPoints, dadosTrein, bias, lambda, distance);

% testData.x = dataset.xtest;
% testData.y = dataset.ytest;
[Yh, error] = test_MLM(model, dadosTeste, type, distance, NN);

% for j = 1: length(testData.y),
%     [~, index(j)] = max(Yh(j,:));
%     [~, target(j)] = max(dadosTeste.y(j, :));
% end
% rate = length(find(index == target))/length(dadosTeste.y);

[~, index] = max(Yh);
[~, target] = max(dadosTeste.y);
confusionmat(target, index)

% [~, numClasses] = size(testData.y);
% confusionMatrix = zeros(numClasses);
% for j = 1 : length(testData.y),
%     confusionMatrix(index(j), target(j)) = confusionMatrix(index(j), target(j)) + 1;
% end
% output = Yh;
% confusionMatrices = confusionMatrix;

    
% targets = dataset.ytest;

% results.acerto = rate
results.k = K;
%results.output = output;
%results.confusionMatrices = confusionMatrices;
%results.targets = targets;
% results.Ecv = Ecv;
end