function [ route, model ] = simRouteBayes( data, conf )
%SIMMLM Summary of this function goes here
%   Detailed explanation goes here


treinData = data.train;
%% Treinamento
fprintf('Treinando o Bayes.\n');
tic
[model] = trainBayes(treinData);
tempoTrein = toc;

for i = 1 : size(data.test,1)
    
    for j = 1 : size(data.test,2)
        
        testData = data.test{i,j};
        Ntest = length(testData.y);
        
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

