function [ result, modelo ] = simRouteMLM(data, conf)
%SIMMLM Summary of this function goes here
%   Detailed explanation goes here


treinData = data.train;
%% Treinamento
% 1-of-k
if ( size(treinData.y, 2) == 1)
    numLabels = unique(treinData.y);
    treinData.y = dataNum2Vec( treinData.y, numLabels );
end


fprintf('Treinando a MLM.\n');
tic
[modelo] = train_MLM(treinData, conf);
tempoTrein = toc;

for i = 1 : size(data.test,1)
    
    for j = 1 : size(data.test,2)
        
        testData = data.test{i,j};
        Ntest = length(testData.y);
        
        
        if ( size(testData.y, 2) == 1)
            testData.y = dataNum2Vec( testData.y, numLabels );
        end        
        

        %% Teste
        fprintf('Step %d. Testando a MLM.\n', i);
        tic
        [Y, ~, y_] = test_MLM(modelo, testData, conf);
        tempoTeste(j) = toc/Ntest;
        
        Y = vec2ind(Y')';
        hit(j) = (sum(Y == vec2ind(testData.y')') == length(Y));
        
        if (not(hit(j)))
            
            indNotHit = find((Y == vec2ind(testData.y')') == 0);
            Y(indNotHit) = y_(2, indNotHit);
            
            hitRej(j) = (sum(Y == vec2ind(testData.y')') == length(Y));            
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