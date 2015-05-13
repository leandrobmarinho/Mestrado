close all; clear all; clc; addpath('..');

%% Pré-processamento
% dados = carregaDados('iris.data', 0);
bd = load('../dados/iris.data');
dados.x = bd(:, 1:4);
dados.y = bd(:, 5);

%% Configurações gerais
ptrn = 0.8;
numRepet = 10;


%%
for i = 1 : numRepet,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 2);    
    
    %% Testando o Bayes
    [Yh] = arvoreDecisao(testData.x);

    %% Matriz de confusao e acurácia
    confusionMatricesTeste{i} = confusionmat(testData.y, Yh);
    accuracy(i) = trace(confusionMatricesTeste{i}) / length(testData.y);
    
end

meanAccuracy = mean(accuracy);


%% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( meanAccuracy - accuracy ) );


%%
results.accMean = meanAccuracy*100
results.std = std(accuracy);
results.confusionMatrix = confusionMatricesTeste{posicoes(1)};
results.confusionMatrices = confusionMatricesTeste;
results.accuracy = accuracy*100;

results.confusionMatrix
