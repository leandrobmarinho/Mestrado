close all; clear all; clc; addpath('..');

%% Pré-processamento
conf.pca = 0.98; conf.selecaoAtr = 0.03;
dados = carregaDados('har', 0, conf);

ptrn = 0.8;
numRodadas = 2;

r1 = przWinSim( dados, ptrn, numRodadas, 0.5); % 0.1 0.5 1 5 10
% r2 = przWinSim( dados, ptrn, numRodadas, 1);
% r3 = przWinSim( dados, ptrn, numRodadas, 10);

somAlerta();