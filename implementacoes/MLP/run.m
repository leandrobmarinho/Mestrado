close all; clear all; clc; addpath('..');

%% Pré-processamento
valores = [ 0.001 0.005 0.007 0.01];
%81p [ 0.001 0.005 *0.007 0.01] 40
%78p [ *0.001 0.005 0.007 0.01] 50
% [ 0.001 0.005 0.007 0.01]
%84p [ 0.001 *0.005 0.01 0.1 ] 60
%82p [ 0.001 0.005 *0.007 0.01] 60
%80p [ 0.001 *0.005 0.007 0.01] 80

for i = 1 : length(valores)
    
    conf.pca = 0.98;
    conf.selecaoAtr = 0.03; %0 *0.03 *0.1 0.3 0.45
    dataset = carregaDados('har', 1, conf);
    
    
    %% Configurações gerais
    ptrn = 0.8;
    numRodadas = 1;
    
    % Topologia da rede
    % floor((size(dataset.x, 2) + 6) /2)
    % *50 30 *60 80 100
    config.L = 55; %numero de neuronios na camada oculta
    config.maxIterations = 150;
    config.lRate = valores(i); %[0.1 *0.05 *0.01 0.03 0.001 0.005]
    
    mlp(dataset, ptrn, numRodadas, config)
    acc(i) = ans.accMean;
end

acc
somAlerta()


%%
% 20 30 50
% 00 00 63