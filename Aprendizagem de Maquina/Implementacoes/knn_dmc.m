function [ results ] = knn_dmc( dataset, K, ptrn, numRepet )

[N, ~] = size(dataset.x);
limit = floor(ptrn*N);

for i = 1 : numRepet,
    %% Embaralhando os dados
    ind = randperm(N);
    
    trainData.x = dataset.x(ind(1:limit), :);
    trainData.y = dataset.y(ind(1:limit), :);
    
    testData.x = dataset.x(ind(limit+1:end), :);
    testData.y = dataset.y(ind(limit+1:end), :);
    
     %% Treinando o DMC
    [centroides] = trainDMC(trainData);
    
    %% Testando o DMC
    [YhDMC] = testeDMC(centroides, testData);
    
    
    %% Testando o K-NN
    [YhKNN] = testeKNN(trainData, testData, K);
    
    
    %% Matriz de confusao e acurácia KNN
    [~, indexDMC] = max(YhDMC');
    [~, target] = max(testData.y');
    
%     keyboard
    confusionMatricesDMC{i} = confusionmat(target, indexDMC);
    accuracyDMC(i) = trace(confusionMatricesDMC{i}) / length(testData.y);
    
    
    %% Matriz de confusao e acurácia KNN
    [~, indexKNN] = max(YhKNN');
    
    confusionMatricesKNN{i} = confusionmat(target, indexKNN);
    accuracyKNN(i) = trace(confusionMatricesKNN{i}) / length(testData.y);
    
    
end

meanAccuracyDMC = mean(accuracyDMC);

%% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( meanAccuracyDMC - accuracyDMC ) );

%%
results.accuracyDMC = meanAccuracyDMC;
results.stdDMC = std(accuracyDMC);
results.confusionMatrixDMC = confusionMatricesDMC{posicoes(1)};
results.confusionMatrixesDMC = confusionMatricesDMC;



meanAccuracyKNN = mean(accuracyKNN);
%% Procurando a matriz de confusão mais próxima da acurácia média KNN
[~, posicoes] = sort( abs ( meanAccuracyKNN - accuracyKNN ) );
results.accuracyKNN = meanAccuracyKNN;
results.stdKNN = std(accuracyKNN);
results.confusionMatrixKNN = confusionMatricesKNN{posicoes(1)};
results.confusionMatrixesKNN = confusionMatricesKNN;


end

