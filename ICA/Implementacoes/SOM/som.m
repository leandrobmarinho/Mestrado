function [ results ] = som( dados, ptrn, numRepet, config)

for i = 1 : numRepet,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 2);
    
    
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

