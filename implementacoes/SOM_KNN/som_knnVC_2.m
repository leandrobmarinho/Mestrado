function [ results ] = som_knnVC_2(dados, params, conf)

for i = 1 : conf.rodadas,    
    %% Embaralhando os dados
    [trainData{i}, testData{i}] = embaralhaDados(dados, conf.ptrn, 2);
    save('resultadoSOM-KNN_VC');
    
    %% Validação cruzada
    fprintf('Buscando a melhor topologia...\n')
    [optParams{i}, Evc{i}] = otimizadorSOMKNN(trainData{i}, params, conf.folds);
    
    %% Treinamento da SOM
    fprintf('Treinando a SOM_K-NN...\nRodada %d\n', i)
    [modelo{i}] = trainVC(trainData{i}, optParams{i}, conf.treinos, conf.ptrn);
    
    %% Testando a SOM
    fprintf('Testando a SOM...\nRodada %d\n\n', i)
    [Yh] = testeSOM_KNN(modelo{i}, testData{i});
    
    %% Matriz de confusao e acurácia    
    confusionMatrices{i} = confusionmat(testData{i}.y, Yh);
    accuracy(i) = trace(confusionMatrices{i}) / length(find(Yh ~= 0));
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


end

