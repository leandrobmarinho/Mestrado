function [ result ] = simMLP( dados, ptrn, numRodadas, conf )
%SIMKNN Summary of this function goes here
%   Detailed explanation goes here
%   

Ntest = size(dados.y, 1) - floor(size(dados.y, 1)*(ptrn)); %num dados teste
for i = 1 : numRodadas
    %% Embaralhando os dados
    [dadosTrein, dadosTeste] = embaralhaDados(dados, ptrn, 2);

        
    %% Treinamento
    tic
    [modelo{i}] = treinoMLP(dadosTrein, conf);
    tempoTrein(i) = toc;
    
    
    %% Avaliando o conjunto de treinamento
    [Yh] = testeMLP(modelo{i}, dadosTrein); 
    [~, target] = max(dadosTrein.y');
    confMatTreino(:,:,i) = confusionmat(target, Yh);
    accTrein(i) = trace(confMatTreino(:,:,i)) / length(dadosTrein.y);
    
    
    %% Teste
    tic
    [Yh] = testeMLP(modelo{i}, dadosTeste);
    tempoTeste(i) = mean(toc);
    [~, target] = max(dadosTeste.y');
    confMatTeste(:,:,i) = confusionmat(target, Yh);
    
    
    %% Metricas
    matConfPorc(:,:,i) = (confMatTeste(:,:,i)./Ntest).*100;
    [metricas(:,:,i), metricasGeral(i,:)] = metricasMatConf(confMatTeste(:,:,i));    
end

% Resultado geral
result.matConfTesteMedia = mean(confMatTeste, 3);
result.matConfPorcMedia = mean(matConfPorc,3);
result.metricasMedia = mean(metricas, 3);
result.metricasGeralMedia = mean(metricasGeral,1);

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

end

