function [results] = bayes(dados, ptrn, numRepet)

for i = 1 : numRepet,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 2);
    
    %% Treinamento do Bayes
    tic
    [modelo{i}] = trainBayes(trainData);
    tempoTrein(i) = toc;
    
    %% Avaliando o conjunto de treinamento
    [Yh] = testeBayes(modelo{i}, trainData);
    confusionMatricesTrain{i} = confusionmat(trainData.y, Yh);
    accuracyTrain(i) = trace(confusionMatricesTrain{i}) / length(trainData.y);
    
    
    %% Testando o Bayes
    tic
    [Yh] = testeBayes(modelo{i}, testData);
    tempoTeste(i) = toc;
    
    %% Matriz de confusao e acurácia
    confusionMatricesTeste{i} = confusionmat(testData.y, Yh);
    accuracyTeste(i) = trace(confusionMatricesTeste{i}) / length(testData.y);
    
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