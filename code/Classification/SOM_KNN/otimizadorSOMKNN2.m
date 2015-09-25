function [ optParam, Ecv ] = otimizadorSOMKNN2(dados, params, nFolds)
%OTIMIZADORSOMKNN Summary of this function goes here
%   Detailed explanation goes here

N = size(dados.x, 1);
if(nFolds == N),
    CVO = cvpartition(N, 'Leaveout');
else
    CVO = cvpartition(N, 'kfold', nFolds);
end

keyboard % OLHAR COMO E FEITA A DIVISAO DO CONJUNTO DE TREINAMENTO E TESTE NA VC

erros = zeros(nFolds, length(params));
for i = 1: nFolds,
    learnPoints.x = dados.x(training(CVO, i), :);
    learnPoints.y = dados.y(training(CVO, i), :);
    testData.x = dados.x(test(CVO, i), :);
    testData.y = dados.y(test(CVO, i), :);
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

