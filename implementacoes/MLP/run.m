close all; clear all; clc; addpath('..');

%% Pré-processamento
conf.pca = 0.98; conf.selecaoAtr = 0.1; %0.3
dataset = carregaDados('har', 1, conf);

%% Configurações gerais
ptrn = 0.8;
numRodadas = 1;

% Topologia da rede
config.L = 50; %numero de neuronios na camada oculta
%20 30 50
config.maxIterations = 100;
config.lRate = 0.1; %0.05

result = mlp(dataset, ptrn, numRodadas, config)

somAlerta()