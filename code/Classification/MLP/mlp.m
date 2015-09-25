function [results] = mlp(dados, ptrn, numRepet, config)


for i = 1 : numRepet,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 2);
    
    %% Treinamento da MLP
    tic
    [modelo{i}] = treinoMLP(trainData, config);
    tempoTrein(i) = toc;
    
    %% Avaliando o conjunto de treinamento
    [Yh] = testeMLP(modelo{i}, trainData);
    [~, target] = max(trainData.y');
    confusionMatricesTrain{i} = confusionmat(target, Yh);
    accuracyTrain(i) = trace(confusionMatricesTrain{i}) / length(target);
    
    
    %% Testando a MLP
    tic
    [Yh] = testeMLP(modelo{i}, testData);
    tempoTeste(i) = toc;
    
    [~, target] = max(testData.y');
    %% Matriz de confusao e acurácia
    confusionMatricesTeste{i} = confusionmat(target, Yh);
    accuracyTeste(i) = trace(confusionMatricesTeste{i}) / length(target);
    
end

meanAccuracy = mean(accuracyTeste);
meanAccuracyTrain = mean(accuracyTrain);


%% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( meanAccuracy - accuracyTeste ) );
[~, posicoesTrain] = sort( abs ( meanAccuracyTrain - accuracyTrain ) );


%%
results.accMean = meanAccuracy*100;
results.std = std(accuracyTeste);
results.confusionMatrix = confusionMatricesTeste{posicoes(1)};
results.confusionMatrices = confusionMatricesTeste;
results.accuracy = accuracyTeste*100;
results.modelos = modelo;

results.accMeanTrain = meanAccuracyTrain*100;
results.stdTrain = std(accuracyTrain);
results.confusionMatrixTrain = confusionMatricesTrain{posicoesTrain(1)};
results.confusionMatricesTrain = confusionMatricesTrain;
results.accuracyTrain = accuracyTrain*100;

results.tempoTrein = tempoTrein;
results.tempoTeste = tempoTeste;

end