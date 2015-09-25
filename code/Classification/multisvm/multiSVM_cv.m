function [ result ] = multiSVM_cv( data, numRodadas, ptrn, params, numFolds )
%SIMMULTISVM Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : numRodadas,
    
    [dadosTrein, dadosTeste] = embaralhaDados(data, ptrn, 2);
    
    [optParams{i}, Ecv{i}] = otimizadorMultiSVM(dadosTrein, params, numFolds);
    
    results = multisvm(dadosTrein.x, dadosTrein.y, dadosTeste.x, optParams{i});
    
    matrizesConf{i} = confusionmat(dadosTeste.y, results);
    acuracia(i) = trace(matrizesConf{i}) / length(results);
    
end

mediaAcc = mean(acuracia);

% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( mediaAcc - acuracia ) );


result.desvPadr = std(acuracia);
result.matrizConfMedia = matrizesConf{posicoes(1)};
result.media = mediaAcc;
result.optParams = optParams;
result.matrizesConf = matrizesConf;
end

