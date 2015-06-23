function [optParam, Ecv] =  optimize_Perceptron(data, params, nFolds, isClassificacao)

N = size(data.x, 1);
if(nFolds == N),
    CVO = cvpartition(N, 'Leaveout');
else
    CVO = cvpartition(N, 'kfold', nFolds);
end

erros = zeros(nFolds, length(params));
for i = 1: nFolds,
    learnPoints.x = data.x(training(CVO, i), :);
    learnPoints.y = data.y(training(CVO, i), :);
    testData.x = data.x(test(CVO, i), :);
    testData.y = data.y(test(CVO, i), :);
    for j = 1: length(params),
        alfa = params{j}(1);
        epocas = params{j}(2);
        
        [modelo] = treinoPerceptron(learnPoints, alfa, epocas);
        [~, erros(i, j)] = testePerceptron(modelo, testData, isClassificacao);
    end
end
Ecv = mean(erros);
[~, indice] = min(Ecv);
optParam = params{indice};

end