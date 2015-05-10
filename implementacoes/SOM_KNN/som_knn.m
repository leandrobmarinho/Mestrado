function [ results ] = som_knn( dados, ptrn, numRepet, config)

for i = 1 : numRepet,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 2);
    
    %% Treinamento da SOM
    fprintf('Treinando a SOM_K-NN...\nRodada %d\n', i)
    tic
    [modelo{i}, ~] = trainSOM_KNN(trainData, config);
    tempoTrein(i) = toc
    
    %% Testando a SOM
    fprintf('Testando a SOM...\nRodada %d\n\n', i)
    [Yh] = testeSOM_KNN(modelo{i}, testData);
    
    %% Matriz de confusao e acurácia    
    tic
    confusionMatrices{i} = confusionmat(testData.y, Yh);
    accuracy(i) = trace(confusionMatrices{i}) / length(find(Yh ~= 0));
    tempoTeste(i) = toc
end

meanAccuracy = mean(accuracy);

%% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( meanAccuracy - accuracy ) );


%%
results.mean = meanAccuracy;
results.std = std(accuracy);
results.confusionMatrix = confusionMatrices{posicoes(1)};
results.confusionMatrices = confusionMatrices;
results.modelos = modelo;

results.trainData = trainData;
results.testData = testData;
results.tempoTrein = tempoTrein;
results.tempoTeste = tempoTeste;

results.accuracy = accuracy;

end

