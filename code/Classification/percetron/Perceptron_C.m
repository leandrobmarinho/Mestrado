function [results] = Perceptron_C(dataset, params, nFolds)


numberRepetitions = length(dataset.xtrain);
%% metodologia basica
for i = 1: numberRepetitions,
    data.x = dataset.xtrain{i};
    data.y = dataset.ytrain{i};
    
    [optParams, Ecv{i}] = optimize_Perceptron(data, params, nFolds, true);    
    alfa(i) = optParams(1);
    epocas(i) = optParams(2);
    
    [model] = treinoPerceptron(data, alfa(i), epocas(i));
    
    testData.x = dataset.xtest{i};
    testData.y = dataset.ytest{i};
    [Yh, erro] = testePerceptron(model, testData, true);
    
    
    %% Cria a matriz de confusao
    [~, index] = max(Yh');
    [~, target] = max(testData.y');
    rate = 1 - erro;
    
%     [~, numClasses] = size(testData.y);
%     confusionMatrix = zeros(numClasses);
%     for j = 1 : length(testData.y),
%         confusionMatrix(index(j), target(j)) = confusionMatrix(index(j), target(j)) + 1;
%     end
    rates(i) = rate;
%     output{i} = Yh;
%     confusionMatrices{i} = confusionMatrix;
end

mean(rates)
mean(alfa)
mean(epocas)

% std(rates)
% targets = dataset.ytest;

% results.rates = rates;
results.MSE = mean(rates);
results.stdev = std(rates);
results.alfa = mean(alfa);
results.epocas = mean(epocas);
% results.output = output;
% results.confusionMatrices = confusionMatrices;
% results.targets = targets;
% results.Ecv = Ecv;
% results.params = optParams;

end