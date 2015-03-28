function [trainData, testData] = embaralhaDados( dados, ptrn, tipo )
%EMBARALHADADOS Summary of this function goes here
% dados - dados para embaralhar
% ptrn - porcentagem para treinamento e teste
% tipo [1] - numero de classe desbalanceado
% tipo [2] - numero de classe balanceado

[N, ~] = size(dados.x);

if (tipo == 1)
    limit = floor(ptrn*N);
    ind = randperm(N);
    
    trainData.x = dados.x(ind(1:limit), :);
    trainData.y = dados.y(ind(1:limit), :);
    testData.x = dados.x(ind(limit+1:end), :);
    testData.y = dados.y(ind(limit+1:end), :);
    
elseif ( tipo == 2)
    trainData.x = []; trainData.y = []; testData.x = []; testData.y = [];
    numClass = length(dados.y(1, :));
    for i = 1 : numClass,
        classe = zeros(1, numClass);
        classe(i) = 1;
        
        % Seleciona apenas as amostras com a classe pretendida
        ind = find(classe * dados.y');
        lengthClass = length(ind);
        
        limit = floor(ptrn*lengthClass);
        if not(isempty(ind))
            
            ind = ind(randperm(lengthClass));
            trainData.x = [trainData.x; dados.x(ind(1:limit), :)];
            trainData.y = [trainData.y; dados.y(ind(1:limit), :)];
            
            testData.x = [testData.x; dados.x(ind(limit+1:end), :)];
            testData.y = [testData.y; dados.y(ind(limit+1:end), :)];
        end
    end
    
    % Embaralha os dados
    ind = randperm(length(trainData.x));
    trainData.x = trainData.x(ind, :);
    trainData.y = trainData.y(ind, :);
    
    ind = randperm(length(testData.x));
    testData.x = testData.x(ind, :);
    testData.y = testData.y(ind, :);
     
end

end

