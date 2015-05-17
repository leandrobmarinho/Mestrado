close all; clear all; clc; addpath('..');

%% Pré-processamento
% conf.pca = 0.98;
% conf.selecaoAtr = 0.1; 
dataset = carregaDados('motor.data', 1);

%% Configurações gerais
ptrn = 0.8;
numRodadas = 1;

config.L = 10;
config.maxIterations = 100;
config.lRate = 0.01;

r = mlp(dataset, ptrn, numRodadas, config)
r.confusionMatrix
plot(1:size(r.modelos{1,1}.MSE, 2), r.modelos{1,1}.MSE)