function [ resultado ] = buscaSOMKNN( dadosTrein, dadosTeste, modelos, Ks )
%BUSCATOPOLOGIASOM Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : size(modelos,1),
    learnPoints = dadosTrein{1,i};
    testData = dadosTeste{1,i};
    
    for j = 1: size(modelos,2),

        for k = 1 : length(Ks)
            [modeloNN{i,j,k}] = train2SOM_KNN( learnPoints, Ks(k), modelos{i,j});
            [Yh] = testeSOM_KNN(modeloNN{i,j,k}, testData);
            
            % Calculando erro
            confusionMatrices{i, j, k} = confusionmat(testData.y, Yh);
            txAcert(i, j, k) = trace(confusionMatrices{i,j, k}) / length(find(Yh ~= 0));
            fprintf('%d %d %d Acc: %f\n', i, j, k, txAcert(i, j, k));
        end
    end
end

resultado.matrizesConfuzao = confusionMatrices;
resultado.modelosNN = modeloNN;
resultado.acuracias = txAcert;

end

