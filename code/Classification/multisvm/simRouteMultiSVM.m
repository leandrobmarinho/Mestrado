function [ result ] = simRouteMultiSVM( data, conf)
%SIMMLM Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : size(data,1)
    
    for j = 1 : size(data,2)
        
        %% Shuffle data
        treinData = data{i,j}.train;
        testData = data{i,j}.test;
        
        
        Ntest = size(testData.y, 1);
        
        %% Treinamento e Teste - (LS)SVM
        fprintf('Treinamento e Teste - (LS)SVM.\n');
        [Y, time, y_, acc_train] = multisvm(treinData.x, treinData.y, testData.x, conf);
        tempoTrein(i) = time.trein;
        tempoTeste(i) = time.test/Ntest;
        
        hit(j) = (sum(Y == testData.y') == length(Y));
        if (not(hit(j)))
            
            indNotHit = find((Y == testData.y') == 0);
                        
            y_ = y_./repmat(acc_train, Ntest, 1); %use acc of train as weigth
            
            [~, indC] = sort(y_', 'ascend');
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

