function [ optParam, Ecv ] = otimizadorSOMKNN(dados, params, nFolds)
%OTIMIZADORSOMKNN Summary of this function goes here
%   Detailed explanation goes here


erros = zeros(nFolds, length(params));
for i = 1 : nFolds,
    %% Embaralhando os dados
    [learnPoints, testData] = embaralhaDados(dados, 0.8, 2);

    for j = 1: length(params),
        tic
        fprintf('Validação Cruzada SOM-KNN. Fold: %d - Param: %d\n',i, j);
                
        [modelo, ~] = trainSOM_KNN(learnPoints, params{j});
        [Yh] = testeSOM_KNN(modelo, testData);
        
        % Calculando erro
        erros(i, j) = 1 - (trace(confusionmat(testData.y, Yh)) / length(testData.y));
        
        save('resultadoSOM-KNN_VC');
        toc
    end
end

Ecv = mean(erros);
[~, indice] = min(Ecv);
optParam = params{indice};

end

