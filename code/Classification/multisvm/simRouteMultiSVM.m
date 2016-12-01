function [ result, models ] = simRouteMultiSVM( data, conf)
%SIMMLM Summary of this function goes here
%   Detailed explanation goes here

treinData = data.train;
%% Treinamento
fprintf('Treinando SVM ou LSSVM.\n');
[models, timeTrain, acc_train ] = trainMultSVM(treinData.x, treinData.y, conf );

for i = 1 : size(data.test,1)
    
    for j = 1 : size(data.test,2)
        
        testData = data.test{i,j};
        Ntest = length(testData.y);
        
        %% Treinamento e Teste - (LS)SVM
        fprintf('Teste - (LS)SVM.\n');
        [ Y, timeTest, y_ ] = testMultSVM( models, testData.x);
        tempoTeste(i) = timeTest/Ntest;
        
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
    route{i}.tempoTrein = timeTrain;
end
result.routes = route;


end

