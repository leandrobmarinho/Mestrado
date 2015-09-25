function [ results ] = przWinSim( dados, ptrn, numRodadas, h )
%PRZWINSIM Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : numRodadas,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 1);
    
    
    [modelo{i}] = trainPzWin(trainData);
    [Yh] = testePzWin(modelo{i}, testData, h);
    
    %% Matriz de confusao e acurácia    
    confusionMatrices{i} = confusionmat(testData.y, Yh);
    accuracy(i) = trace(confusionMatrices{i}) / length(testData.y);
    
    fprintf('%d %f\n', i, accuracy(i));
end

meanAccuracy = mean(accuracy);

%% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( meanAccuracy - accuracy ) );


%%
results.accMean = meanAccuracy*100;
results.std = std(accuracy);
results.confusionMatrix = confusionMatrices{posicoes(1)};
results.confusionMatrices = confusionMatrices;
results.modelos = modelo;
results.accuracy = accuracy*100

end