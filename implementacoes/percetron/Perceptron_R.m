function [results] = Perceptron_R(dataset, params, nFolds)


numberRepetitions = length(dataset.xtrain);
%% metodologia basica
for i = 1: numberRepetitions,
    data.x = dataset.xtrain{i};
    data.y = dataset.ytrain{i};
    
    [optParams, Ecv{i}] = optimize_Perceptron(data, params, nFolds, false);
    alfa(i) = optParams(1);
    epocas(i) = optParams(2);
    
    [model] = treinoPerceptron(data, alfa(i), epocas(i));
    
    testData.x = dataset.xtest{i};
    testData.y = dataset.ytest{i};
    [output{i}, erros(i)] = testePerceptron(model, testData, false);
    
end

mean(erros)
mean(alfa)
mean(epocas)

% mean(rates)
% std(rates)
% targets = dataset.ytest;

results.MSE = mean(erros);
results.stdev = std(erros);
results.alfa = alfa;
results.epocas = epocas;

end