function [optParam, Ecv] =  optimizePerceptron(data, params, nFolds)

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
        
        [model] = treinoPerceptron(learnPoints, params{j});
        [Yh, ~] = testePerceptron(model, testData);
        erros(i, j) = 1 - sum(vec2ind(testData.y') == Yh)/length(Yh);
    end
end
Ecv = mean(erros);
[~, indice] = min(Ecv);
optParam = params{indice};

end