function [optParam, Ecv] = searchParamSVM( dados, params, num, ptrn )
%SEARCHPARAMSVM Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : num,
    %% Embaralhando os dados
    [learnPoints, testData] = embaralhaDados(dados, ptrn, 2);
    
    for j = 1: length(params),
        
        %% Treinamento e Teste - (LS)SVM
        fprintf('Treinamento e Teste - (LS)SVM.\n');
        [Y, ~] = multisvm(learnPoints.x, learnPoints.y, testData.x, params{j});        
        confusionMatrices{i, j} = confusionmat(testData.y', Y');
        
        acc(i,j) = trace(confusionMatrices{i, j}) / length(Y);
        
        fprintf('ACC: %f\n',  acc(i, j));
        
    end
end

Ecv = mean(acc,1);
[~, indice] = max(Ecv);
optParam = params{indice};

end

