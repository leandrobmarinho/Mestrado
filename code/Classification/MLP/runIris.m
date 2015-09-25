close all; clear all; clc; addpath('..');

%% Pré-processamento
dados = carregaDados('iris.data', 1);

%% Configurações gerais
ptrn = 0.75;
numRodadas = 10;

% Topologia da rede
config.L = 10; %numero de neuronios na camada oculta
config.maxIterations = 300;
config.lRate = 0.05;

result = mlp(dados, ptrn, numRodadas, config)
% r = simMLP( dados, ptrn, numRodadas, config )

