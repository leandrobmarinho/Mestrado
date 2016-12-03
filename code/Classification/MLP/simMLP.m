function [ result ] = simMLP( data, param )
%SIMMLM Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : length(data)
    %% Embaralhando os dados
%     [treinData, testData] = embaralhaDados(data, ptrn, 2);
    treinData = data{i}.train;
    testData = data{i}.test;
    
    if ( size(treinData.y, 2) == 1)
        treinData.y = full(ind2vec(treinData.y'))';
        testData.y = full(ind2vec(testData.y'))';
    end
    
    Ntest = size(testData.y, 1);

        
    %% Treinamento
    fprintf('Treinando a MLP.\n');
    net = patternnet(param);
    net.trainFcn =  'trainlm';
%         net.trainFcn =  'traingd';
    net.performFcn = 'mse';
    net.trainParam.showWindow = 0;
    
    tic
    net = train(net, treinData.x', treinData.y');
    tempoTrein(i) = toc;
    
            
    %% Teste
    fprintf('Step %d. Testando a MLP.\n', i);    
    tic
    Y = net(testData.x');
    tempoTeste(i) = toc/Ntest;
    classes = vec2ind(Y);    
    confMatTeste(:,:,i) = confusionmat(vec2ind(testData.y'), classes);
        
    
    %% Metricas
    matConfPorc(:,:,i) = (confMatTeste(:,:,i)./Ntest).*100;
    [metricas(:,:,i), metricasGeral(i,:)] = metricasMatConf(confMatTeste(:,:,i));    
end

% Resultado geral
% result.matConfTesteMedia = mean(confMatTeste, 3);
% result.matConfPorcMedia = mean(matConfPorc,3);
% result.metricasMedia = mean(metricas, 3);
result.metricasGeralMedia = mean(metricasGeral,1);

result.matConfTeste = confMatTeste;
result.matConfPorc = matConfPorc;
result.metricas = metricas;
result.metricasGeral = metricasGeral;

% Procura a matriz de confus?o mais pr?xima da acc m?dia
acc = metricasGeral(:,end);
mediaAcc = mean(acc);
[~, pos] = sort( abs ( mediaAcc - acc) );

result.matConfTesteMedia2 = confMatTeste(:,:,pos(1));
result.stdAcc = std(acc);

result.tempoTeste = tempoTeste;
result.tempoTrein = tempoTrein;
% result.tempoTesteMedio = mean(tempoTeste);
% result.tempoTreinMedio = mean(tempoTrein);

end

