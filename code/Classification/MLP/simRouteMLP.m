function [ result ] = simRouteMLP( data, param )
%SIMMLM Summary of this function goes here
%   Detailed explanation goes here


treinData = data.train;
%% Treinamento
fprintf('Treinando MLP.\n');

%% 1-of-k
if ( size(treinData.y, 2) == 1)
    numLabels = unique(treinData.y);
    treinData.y = dataNum2Vec( treinData.y, numLabels );
end



%% Treinamento
fprintf('Treinando a MLP.\n');
net = patternnet(param);
net.trainFcn =  'trainlm';
%         net.trainFcn =  'traingd';
net.trainParam.showWindow = 0;

tic
net = train(net, treinData.x', treinData.y');
tempoTrein = toc;

for i = 1 : size(data.test,1)
    
    for j = 1 : size(data.test,2)
        
        testData = data.test{i,j};
        Ntest = length(testData.y);
        
        
        if ( size(testData.y, 2) == 1)
            testData.y = dataNum2Vec( testData.y, numLabels );
        end

        
        
        %% Teste
        fprintf('Step %d. Testando a MLP.\n', i);
        tic
        y_ = net(testData.x');
        tempoTeste(i) = toc/Ntest;
        
        Y = vec2ind(y_);
        hit(j) = (sum(Y == vec2ind(testData.y')) == length(Y));
        
        if (not(hit(j)))
            
            indNotHit = find((Y == vec2ind(testData.y')) == 0);
            [~, indC] = sort(y_, 'descend');
            Y(indNotHit) = indC(2, indNotHit);
            
            hitRej(j) = (sum(Y == vec2ind(testData.y')) == length(Y));
            
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
