function [trainData, testData] = embaralhaDados( data, ptrn, type )
%EMBARALHADADOS Summary of this function goes here
% dados - dados para embaralhar
% ptrn - porcentagem para treinamento e teste
% tipo [1] - numero de classe desbalanceado
% tipo [2] - numero de classe balanceado

[N, ~] = size(data.x);

if (type == 1)
    limit = floor(ptrn*N);
    inds = randperm(N);
    
    trainData.x = data.x(inds(1:limit), :);
    trainData.y = data.y(inds(1:limit), :);
    testData.x = data.x(inds(limit+1:end), :);
    testData.y = data.y(inds(limit+1:end), :);
    
elseif ( type == 2)
    trainData.x = []; trainData.y = []; testData.x = []; testData.y = [];

    
    if (size(data.y, 2) == 1)
        labels = data.y;
    else
        % 1_of_k representation
        labels = vec2ind(data.y')';
    end
    classes = unique(labels);
    
    numLabels = length(classes);
    for i = 1 : numLabels
        inds = find(labels == classes(i));

        numInds = length(inds);
        
        limit = floor(ptrn*numInds);
        if not(isempty(inds))
            
            inds = inds(randperm(numInds));
            trainData.x = [trainData.x; data.x(inds(1:limit), :)];
            trainData.y = [trainData.y; data.y(inds(1:limit), :)];
            
            testData.x = [testData.x; data.x(inds(limit+1:end), :)];
            testData.y = [testData.y; data.y(inds(limit+1:end), :)];
        end
    end
    
    % Embaralha os dados
    inds = randperm(size(trainData.x,1));
    trainData.x = trainData.x(inds, :);
    trainData.y = trainData.y(inds, :);
    
    inds = randperm(size(testData.x,1));
    testData.x = testData.x(inds, :);
    testData.y = testData.y(inds, :);
     
end

end

