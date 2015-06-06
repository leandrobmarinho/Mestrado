function [ result ] = simKNN( dados, ptrn, numRodadas, conf )
%SIMKNN Summary of this function goes here
%   Detailed explanation goes here
%   

Ntest = size(dados.y, 1) - floor(size(dados.y, 1)*(ptrn)); %num dados teste
for i = 1 : numRodadas
    %% Embaralhando os dados
    [dadosTrein, dadosTeste] = embaralhaDados(dados, ptrn, 2);

        
    %% Treinamento
    tic
%     [modelo{i}] = trainBayes(trainData);
    modelo{i} = dadosTrein;
    tempoTrein(i) = toc;
    
    
    %% Avaliando o conjunto de treinamento
    [Yh] = testeKNN(modelo{i}, dadosTrein, conf);
    confMatTreino(:,:,i) = confusionmat(dadosTrein.y, Yh);
    accTrein(i) = trace(confMatTreino(:,:,i)) / length(dadosTrein.y);
    
    
    %% Teste
    tic
    [Yh] = testeKNN(dadosTrein, dadosTeste, conf);
    tempoTeste(i) = mean(toc);
    confMatTeste(:,:,i) = confusionmat(dadosTeste.y, Yh);
    
    
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

result.modelos = modelo;

% fprintf([repmat('%0.2f\t', 1, size(perc, 2)) '\n'], perc')

% matriz = [
%     344 0 1 0 0 0;
%     0 309 0 0 0 0;
%     1 1 280 0 0 0;
%     0 0 0 330 26 0;
%     0 1 0 28 353 0;
%     0 0 0 0 0 389 ];
% 

end

