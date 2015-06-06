close all; clear all; clc; addpath('..');

%% Pré-processamento
conf.pca = 0.98;
dataset = carregaDados('har', 1, conf);


%% Configurações gerais
ptrn = 0.8;
numRodadas = 5;

% Topologia da rede
config.neurOcul = 100; %numero de neuronios na camada oculta

simMLPtb(dataset, ptrn, numRodadas, config)

somAlerta()