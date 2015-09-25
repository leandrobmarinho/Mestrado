function [ result ] = simMLM( data, ptrn, num, conf )
%SIMMLM Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : num
    %% Shuffling data
    [treinData, testData] = embaralhaDados(data, ptrn, 2);
    Ntest = size(testData.y, 1);
        
    %% Treinamento
    fprintf('Treinando a MLM.\n');
    tic
    [modelo] = train_MLM(treinData, conf);
    tempoTrein(i) = toc;
    
            
    %% Teste
    fprintf('Step %d. Testando a MLM.\n', i);
    tic
    [Y] = test_MLM(modelo, testData, conf);
    tempoTeste(i) = toc/Ntest;
    confMatTeste(:,:,i) = confusionmat(vec2ind(testData.y'), vec2ind(Y'));
    
    
    %% Metricas
    matConfPorc(:,:,i) = (confMatTeste(:,:,i)./Ntest).*100;
    [metricas(:,:,i), metricasGeral(i,:)] = metricasMatConf(confMatTeste(:,:,i));    
end

% Resultado geral
% result.matConfTesteMedia = mean(confMatTeste, 3);
% result.matConfPorcMedia = mean(matConfPorc,3);
% result.metricasMedia = mean(metricas, 3);
result.metricasGeralMedia = mean(metricasGeral);

result.matConfTeste = confMatTeste;
result.matConfPorc = matConfPorc;
result.metricas = metricas;
result.metricasGeral = metricasGeral;

% Procura a matriz de confusão mais próxima da acc média
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

