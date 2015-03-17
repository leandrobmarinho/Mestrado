function [ results ] = som( dataset, ptrn, numRepet, config)

[N, ~] = size(dataset.x);
limit = floor(ptrn*N);

for i = 1 : numRepet,
    %% Embaralhando os dados
    ind = randperm(N);
    
    trainData.x = dataset.x(ind(1:limit), :);
    testData.x = dataset.x(ind(limit+1:end), :);
    
    
    %% Treinamento da SOM
    [erroTrain(i), W] = trainSOM(trainData, config);
    
    
    %% Testando a SOM
    [erroTeste(i)] = testeSOM(W, testData);
        
end


%%
results.erroTeste =  mean(erroTeste);
results.stdTeste = std(erroTeste);

results.erroTrain =  mean(erroTrain);
results.stdTrain = std(erroTrain);

end

