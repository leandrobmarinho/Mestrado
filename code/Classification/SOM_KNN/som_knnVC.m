function [ results ] = som_knnVC( dados, ptrn, numRepet, params, nFolds)

for i = 1 : numRepet,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 2);
    
    
    %% Validação cruzada
    fprintf('Buscando a melhor topologia...\n')
    [optParams{i}, Ecv{i}] = otimizadorSOMKNN(trainData, params, nFolds);
    
    
    %% Treinamento da SOM
    fprintf('Treinando a SOM_K-NN...\nRodada %d\n', i)
    [modelo, ~] = trainSOM_KNN(trainData, optParams{i});    
    
    %% Testando a SOM
    fprintf('Testando a SOM...\nRodada %d\n\n', i)
    [Yh] = testeSOM_KNN(modelo, testData);
    
    %% Matriz de confusao e acurácia    
    confusionMatrices{i} = confusionmat(testData.y, Yh);
    accuracy(i) = trace(confusionMatrices{i}) / length(find(Yh ~= 0));
end

meanAccuracy = mean(accuracy);

%% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( meanAccuracy - accuracy ) );


%%
results.mean = meanAccuracy;
results.std = std(accuracy);
results.confusionMatrix = confusionMatrices{posicoes(1)};
results.confusionMatrices = confusionMatrices;

results.accuracy = accuracy;
results.optParams = optParams;
end

