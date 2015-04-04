function [ results ] = som( dados, ptrn, numRepet, config)

for i = 1 : numRepet,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 2);
    
    
    %% Treinamento da SOM
    fprintf('Treinando a SOM...\nRodada %d\n', i)
    [erroTrain(i), W] = trainSOM(trainData, config);
    
    
    %% Testando a SOM
    fprintf('Testando a SOM...\nRodada %d\n\n', i)
    [erroTeste(i)] = testeSOM(W, testData);
        
end


%%
results.testeMean =  mean(erroTeste);
results.stdTeste = std(erroTeste);
results.erroTeste = erroTeste;

results.trainMean =  mean(erroTrain);
results.stdTrain = std(erroTrain);
results.erroTrain = erroTrain;
end

