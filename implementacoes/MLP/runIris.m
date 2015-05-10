close all; clear all; clc; addpath('..');

%% Pré-processamento
dataset = carregaDados('iris.data', 1);

%% Configurações gerais
ptrn = 0.75;
numRepet = 10;

% Topologia da rede
config.L = 10; %numero de neuronios na camada oculta
config.maxIterations = 100;
config.lRate = 0.1;

result = mlp(dataset, ptrn, numRepet, config)

