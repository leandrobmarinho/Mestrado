function [results] = KNN(dataset, K, ptrn, numRepet)


[N, ~] = size(dataset.x);
limit = floor(ptrn*N);

for i = 1 : numRepet,
    %% Embaralhando os dados
    ind = randperm(N);
    
    trainData.x = dataset.x(ind(1:limit), :);
    trainData.y = dataset.y(ind(1:limit), :);
    
    testData.x = dataset.x(ind(limit+1:end), :);
    testData.y = dataset.y(ind(limit+1:end), :);
    
    
    %% Testando o classificador
    [Yh] = testeKNN(trainData, testData, K);
    
    
    %% Matriz de confusao e acurácia
    [~, index] = max(Yh');
    [~, target] = max(testData.y');
    
    accuracy(i) = trace(confusionmat(target, index)) / length(testData.y);
end


%%
% results.k = K;
% results.accuracy = meanAccuracy;
% results.std = std(accuracy);
% results.confusionMatrix = confusionMatrices{posicoes(1)};
% results.confusionMatrices = confusionMatrices;

results(1) = K;
results(2) = mean(accuracy);
results(3) = std(accuracy);

end