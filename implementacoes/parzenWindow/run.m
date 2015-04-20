close all; clear all; clc; addpath('..');

%% Pré-processamento
dados = carregaDados('iris.data', 0, -1);

%% Configurações gerais
ptrn = 0.75;
numRodadas = 10;
h = 0.1;

for i = 1 : numRodadas,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 1);
    
    
    [modelo] = trainPzWin(trainData);
    [Yh] = testePzWin(modelo, testData, h);
    
    %% Matriz de confusao e acurácia    
    confusionMatrices{i} = confusionmat(testData.y, Yh);
    accuracy(i) = trace(confusionMatrices{i}) / length(testData.y);
    
end

meanAccuracy = mean(accuracy);

%% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( meanAccuracy - accuracy ) );


%%
results.accMean = meanAccuracy*100;
results.std = std(accuracy);
results.confusionMatrix = confusionMatrices{posicoes(1)};
results.confusionMatrices = confusionMatrices;
results.accuracy = accuracy*100