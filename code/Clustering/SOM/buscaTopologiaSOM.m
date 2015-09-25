function [ resultado ] = buscaTopologiaSOM( dados, params, conf )
%BUSCATOPOLOGIASOM Summary of this function goes here
%   Detailed explanation goes here

save('topologiaSOM');
errosTrein = zeros(conf.treinos, length(params));
errosTeste = zeros(conf.treinos, length(params));
for i = 1 : conf.treinos,
    %% Embaralhando os dados
    [learnPoints{i}, testData{i}] = embaralhaDados(dados, conf.ptrn, 2);
    
    for j = 1: length(params),
        tic
        fprintf('Busca Topologia SOM. %d - %d.\n', i, j);
        [modelo{i,j}, errosQuantTrein{i,j}] = trainSOM(learnPoints{i}, params{j});
        tempoTrein(i,j) = toc;
        errosTrein(i, j) = mean(errosQuantTrein{i,j});
        
        [errosTeste(i, j)] = testeSOM(modelo{i,j}, testData{i});        
        
        fprintf('ErroTrein: %f. ErroTeste: %f\n', errosTrein(i, j), errosTeste(i, j));
        
        save('topologiaSOM','-append');
        
    end
end

if conf.treinos == 1
    resultado.varianciaTrein = zeros(1, size(errosTrein,2));
    resultado.varianciaTeste = zeros(1, size(errosTeste,2));
else
    resultado.varianciaTrein = var(errosTrein, 1);
    resultado.varianciaTeste = var(errosTeste, 1);
end
resultado.mediaTrein = mean(errosTrein, 1);
resultado.mediaTeste = mean(errosTeste, 1);
resultado.tempoTreino = tempoTrein;

save('topologiaSOM','-append');

end

