function [ result ] = simMLPtb( dados, ptrn, numRodadas, conf )
%SIMKNN Summary of this function goes here
%   Detailed explanation goes here
%   

Ntest = size(dados.y, 1) - floor(size(dados.y, 1)*(ptrn)); %num dados teste
for i = 1 : numRodadas
    %% Embaralhando os dados
    [dadosTrein{i}, dadosTeste{i}] = embaralhaDados(dados, ptrn, 2);

        
    %% Treinamento
    rede{i} = patternnet(conf.neurOcul);
    tic
    rede{i} = train(rede{i}, dadosTrein{i}.x', dadosTrein{i}.y');
    tempoTrein(i) = toc;   
        
    
    %% Avaliando o conjunto de treinamento
    y = rede{i}(dadosTrein{i}.x');
    classes = vec2ind(y);    
    confMatTreino(:,:,i) = confusionmat(vec2ind(dadosTrein{i}.y'), classes);
    accTrein(i) = trace(confMatTreino(:,:,i)) / length(dadosTrein{i}.y);
    
    
    %% Teste
    tic
    y = rede{i}(dadosTeste{i}.x');
    tempoTeste(i) = mean(toc);
    classes = vec2ind(y);    
    confMatTeste(:,:,i) = confusionmat(vec2ind(dadosTeste{i}.y'), classes);
    
    
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

result.modelos = rede;

result.dadosTrein = dadosTrein;
result.dadosTeste = dadosTeste;

end

