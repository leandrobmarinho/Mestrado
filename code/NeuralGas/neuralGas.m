function [ results ] = neuralGas( dados, ptrn, numRepet, config)

for i = 1 : numRepet,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 2);
    
    
    %% Treinamento da SOM
    [erroTrain(i), W] = trainNeuralGas(trainData, config);
    
    
    %% Testando a SOM
    [erroTeste(i)] = testeNeuralGas(W, testData);
        
end


%%
results.testeMean =  mean(erroTeste);
results.stdTeste = std(erroTeste);
results.erroTeste = erroTeste;

results.trainMean =  mean(erroTrain);
results.stdTrain = std(erroTrain);
results.erroTrain = erroTrain;
end

