function [results] = bayesCusto(dados, ptrn, numRepet, conf)

custo = conf.custo;
for i = 1 : numRepet,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 2);
    
    
    %% Treinamento do Bayes
    [modelo] = trainBayes(trainData);
    
    
    %% Testando o DMC
    conf.custo = custo;
    [Yh1] = testeBayes(modelo, testData, conf);
    
    conf.custo = 1 - eye(length(unique(dados.y)));
    [Yh2] = testeBayes(modelo, testData, conf);
    
%     keyboard
    %% Matriz de confusao e acurácia
    confusionMatrices1{i} = confusionmat(testData.y, Yh1');
    accuracy1(i) = trace(confusionMatrices1{i}) / length(testData.y);
    
    confusionMatrices2{i} = confusionmat(testData.y, Yh2');
    accuracy2(i) = trace(confusionMatrices2{i}) / length(testData.y);
end

meanAccuracy1 = mean(accuracy1);
meanAccuracy2 = mean(accuracy2);


%% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes1] = sort( abs ( meanAccuracy1 - accuracy1 ) );
[~, posicoes2] = sort( abs ( meanAccuracy2 - accuracy2 ) );



%%
results.accMean1 = meanAccuracy1*100;
results.std1 = std(accuracy1);
results.confusionMatrix1 = confusionMatrices1{posicoes1(1)};
results.confusionMatrices1 = confusionMatrices1;
results.accuracy1 = accuracy1;


results.accMean2 = meanAccuracy2*100;
results.std2 = std(accuracy2);
results.confusionMatrix2 = confusionMatrices2{posicoes2(1)};
results.confusionMatrices2 = confusionMatrices2;
results.accuracy2 = accuracy2;


end