function [ results ] = somNN( dados, rede, conf )
%SOMNN Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : conf.rodadas,    
    %% Embaralhando os dados
    [trainData{i}, testData{i}] = embaralhaDados(dados, conf.ptrn, 2);
    
    %% Treinamento da SOM
    fprintf('Treinando a SOM_K-NN...\nRodada %d\n', i)
    tic
    [modelo{i}] = trainVC(trainData{i}, rede, conf.treinos, conf.ptrn);
    tempoTrein(i) = toc
    
    %% Testando a SOM
    fprintf('Testando a SOM...\nRodada %d\n\n', i)
    tic
    [Yh] = testeSOM_KNN(modelo{i}, testData{i});
    
    %% Matriz de confusao e acurácia    
    confusionMatrices{i} = confusionmat(testData{i}.y, Yh);
    accuracy(i) = trace(confusionMatrices{i}) / length(find(Yh ~= 0))
    tempoTeste(i) = toc
end

meanAccuracy = mean(accuracy);

%% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( meanAccuracy - accuracy ) );


%%
results.mean = meanAccuracy;
results.std = std(accuracy);
results.matrizConfuzaoMedia = confusionMatrices{posicoes(1)};
results.matrizConfuzao = confusionMatrices;

results.accuracy = accuracy;
results.optParams = optParams;
results.ErroVC = Evc;
results.modelos = modelo;
results.trainData = trainData;
results.testData = testData;
results.tempoTrein = tempoTrein;
results.tempoTeste = tempoTeste;


end

