close all; clear all; clc; addpath('..');

%% Pré-processamento
conf.pca = 0.98;
dataset = carregaDados('har', 1, conf);


%% Configurações gerais
ptrn = 0.8;
numRodadas = 5;

% Topologia da rede
config.L = 100; %numero de neuronios na camada oculta
config.maxIterations = 300;
config.lRate = 0.01; %[0.1 *0.05 *0.01 0.03 0.001 0.005] 0.001

simMLP(dataset, ptrn, numRodadas, config)

somAlerta()