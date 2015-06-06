function [ result ] = simMLM( dados, ptrn, numRodadas, conf )
%SIMMLM Summary of this function goes here
%   Detailed explanation goes here

Ntest = size(dados.y, 1) - floor(size(dados.y, 1)*(ptrn)); %num dados teste
for i = 1 : numRodadas
    %% Embaralhando os dados
    [dadosTrein, dadosTeste] = embaralhaDados(dados, ptrn, 2);

        
    %% Treinamento
    fprintf('Treinando a MLM.\n');
    tic
    [modelo] = train_MLM(dadosTrein, conf);
    tempoTrein(i) = toc;
    
    
    %% Avaliando o conjunto de treinamento
    fprintf('Validando o conjunto de treinamento.\n');
    [Y, ~] = test_MLM(modelo, dadosTrein, conf);
    confMatTreino(:,:,i) = confusionmat(vec2ind(dadosTrein.y'), vec2ind(Y'));
    accTrein(i) = trace(confMatTreino(:,:,i)) / length(dadosTrein.y);
    
    
    %% Teste
    fprintf('Testando a MLM.\n');
    tic
    [Y] = test_MLM(modelo, dadosTeste, conf);
    tempoTeste(i) = mean(toc);
    confMatTeste(:,:,i) = confusionmat(vec2ind(dadosTeste.y'), vec2ind(Y'));
    
    
    %% Metricas
    matConfPorc(:,:,i) = (confMatTeste(:,:,i)./Ntest).*100;
    [metricas(:,:,i), metricasGeral(i,:)] = metricasMatConf(confMatTeste(:,:,i));    
end

% Resultado geral
result.matConfTesteMedia = mean(confMatTeste, 3);
result.matConfPorcMedia = mean(matConfPorc,3);
result.metricasMedia = mean(metricas, 3);
result.metricasGeralMedia = mean(metricasGeral);

result.matConfTeste = confMatTeste;
result.matConfPorc = matConfPorc;
result.metricas = metricas;
result.metricasGeral = metricasGeral;

result.matrizesConfTeste = confMatTeste;
result.matrizesConfTrain = confMatTreino;

% Procura a matriz de confusão mais próxima da acc média
acc = metricasGeral(:,end);
mediaAcc = mean(acc);
[~, pos] = sort( abs ( mediaAcc - acc) );

result.matConfTesteMedia2 = confMatTeste(:,:,pos(1));
result.stdAcc = std(acc);
result.accTrein = accTrein;

result.tempoTeste = tempoTeste;
result.tempoTrein = tempoTrein;
result.tempoTesteMedio = mean(tempoTeste);
result.tempoTreinMedio = mean(tempoTrein);

end

