close all; clear all; clc; addpath('..');

%% Pré-processamento
conf.pca = 0.98;
conf.selecaoAtr = 0.1;
dataset = carregaDados('har', 1, conf);


%% Configurações gerais
ptrn = 0.8;
numRodadas = 10;

% Topologia da rede
config.nOcultos = 960;
config.gamma = 0.01;

rbf(dataset, ptrn, numRodadas, config)

somAlerta()