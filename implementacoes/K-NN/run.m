close all; clear all; clc; addpath('../');

%% Pré-processamento
conf.pca = 0.98;
conf.selecaoAtr = 0.1;
dados = carregaDados('har', 1, conf);


%% Configurações gerais
ptrn = 0.8;
numRodadas = 10;

r = simKNN( dados, ptrn, numRodadas, 1)
