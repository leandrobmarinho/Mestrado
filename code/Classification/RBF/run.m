close all; clear all; clc; addpath('..'); addpath('../SOM');


%% Pré-processamento
conf.pca = 0.98;
conf.selecaoAtr = 0.1;
dataset = carregaDados('har', 1, conf);


%% Configurações gerais
ptrn = 0.8;
numRodadas = 10;

% Topologia da rede
config.v_i = 0.09; %0.9
config.v_f = 0.085; %0.85
config.alfa_i = 0.01; % 0.01 10.1 0.01 -0.00001
config.alfa_f = 0.01;

config.tamanho = [20 20];
config.gamma = 0.01;

rbf(dataset, ptrn, numRodadas, config)

somAlerta()