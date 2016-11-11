function [optParam, Ecv] = searchParamSVM( dados, params, num, ptrn )
%SEARCHPARAMSVM Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : num,
    %% Embaralhando os dados
    [learnPoints, testData] = embaralhaDados(dados, ptrn, 2);
    
    fprintf('%d - Treinamento e Teste - (LS)SVM.\n', i);
    for j = 1: length(params),        
        
        %% Treinamento e Teste - (LS)SVM
        [Y, ~] = multisvm(learnPoints.x, learnPoints.y, testData.x, params{j});
        confusionMatrices{i, j} = confusionmat(testData.y', Y');
        
        acc(i,j) = trace(confusionMatrices{i, j}) / length(Y);
        
        if (isfield(params{j}, 'sigma') )
            fprintf('ACC: %f %f %f %s\n', acc(i, j), params{j}.paraC, ...
                params{j}.sigma, params{j}.metodo);
        else
            fprintf('ACC: %f %f %s \n', acc(i, j), params{j}.paraC, ...
                params{j}.metodo);
        end
        
    end
end

Ecv = mean(acc,1);
[~, indice] = max(Ecv);
optParam = params{indice};

end

