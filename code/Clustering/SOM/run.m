close all; clear all; clc; addpath('..');

%% Pré-processamento
conf.pca = 0.98; conf.selecaoAtr = 0.1;
dataset = carregaDados('har', 0, conf);

%% Configurações gerais
ptrn = 0.75;
numRodadas = 1;

% Topologia da rede
config.vizinhos = 3;
config.topologia = 'h'; %g grid; h hexagonal
config.dist = 'l'; % b boxdist; l linkdist
config.tamanho = [20 20];
config.epocas = 50;
config.v_i = 0.09;
config.v_f = 0.085;
config.alfa_i = 0.01;
config.alfa_f = 0.01;

result = som(dataset, ptrn, numRodadas, config)