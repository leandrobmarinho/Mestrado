function [ route ] = simRouteBayes( data, conf )
%SIMMLM Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : size(data,1)
    
    for j = 1 : size(data,2)
        
        %% Embaralhando os dados
        treinData = data{i,j}.train;
        testData = data{i,j}.test;
        
        Ntest = size(testData.y, 1);
        
        %% Treinamento
        fprintf('Treinando o Bayes.\n');
        tic
        [model] = trainBayes(treinData);
        tempoTrein(j) = toc;
        
        
        %% Teste
        fprintf('Step %d. Testando o Bayes.\n', j);
        tic
        [Y, ~, y_] = testeBayes(model, testData, conf);
        tempoTeste(j) = toc/Ntest;
        
        hit(j) = (sum(Y == testData.y') == length(Y));
        if (not(hit(j)))
            indNotHit = find((Y == testData.y') == 0);
            
            [~, indC] = sort(y_, 'descend');
            Y(indNotHit) = indC(2, indNotHit);
            
            hitRej(j) = (sum(Y == testData.y') == length(Y));
        else
            hitRej(j) = hit(j);
        end
        
    end
    
    % Result by route
    route{i}.hit = double(hit);
    route{i}.hitRej = double(hitRej);
    route{i}.tempoTeste = tempoTeste;
    route{i}.tempoTrein = tempoTrein;
end
result.routes = route;


end

