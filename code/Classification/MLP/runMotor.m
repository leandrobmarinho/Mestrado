close all; clear all; clc; addpath('..');

%% Pré-processamento
% conf.pca = 0.98;
% conf.selecaoAtr = 0.1; 
conf.normaliza = true;
dataset = carregaDados('motor.data', 1, conf);

%% Configurações gerais
ptrn = 0.8;
numRodadas = 3;

config.L = 4;
config.maxIterations = 200;
config.lRate = 0.005;

r = mlp(dataset, ptrn, numRodadas, config)
r.confusionMatrix
plot(1:size(r.modelos{1,3}.MSE, 2), r.modelos{1,3}.MSE)