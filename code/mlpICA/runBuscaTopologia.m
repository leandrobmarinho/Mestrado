clear all; close all; clc; addpath('../');


%% Carregando os dados
data = load('coluna_Dtreina.dat');
dadosTrein.x = data(:, 1:6);
dadosTrein.x = normalizaDados(dadosTrein.x,1);
dadosTrein.y = data(:, 7:end);
data = load('coluna_Dvalida.dat');
dadosTeste.x = data(:, 1:6);
dadosTeste.x = normalizaDados(dadosTeste.x,1);
dadosTeste.y = data(:, 7:end);
clear data;


%% Configurações
numNeur = 5:5:50; %5:5:50
rodadas = 5;
rede.maxIterations = 200;
rede.alfa_i = 0.01;
rede.alfa_f = 0.001;
fileName = 'topologiasMLP';

% save(conf.fileName);
for i = 1 : rodadas,
    %% Embaralhando os dados
    ind = randperm(size(dadosTrein.y,1));
    dadosTrein.x = dadosTrein.x(ind, :);
    dadosTrein.y = dadosTrein.y(ind, :);
    
    ind = randperm(size(dadosTeste.y,1));
    dadosTeste.x = dadosTeste.x(ind, :);
    dadosTeste.y = dadosTeste.y(ind, :);
    
    
    %%
    for j = 1: length(numNeur),
        rede.L = numNeur(j);
        fprintf('Busca Topologia MLP. %d - %d.\n', i, j);
        tic        
        [modelo{i,j}] = treinoMLP(dadosTrein, rede);
        tempoTrein(i,j) = toc;
        
        Yh = testeMLP(modelo{i,j}, dadosTeste);        
        
        target = vec2ind(dadosTeste.y');
        confusionMatrices{i, j} = confusionmat(target, Yh);
        acc(i,j) = trace(confusionMatrices{i, j}) / length(target);
                
        fprintf('ACC: %f\n',  acc(i, j));
        
%         save(fileName,'-append');
        
    end
end
mean(acc,1)

% save(fileName,'-append');


