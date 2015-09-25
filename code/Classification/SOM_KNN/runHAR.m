close all; clear all; clc; addpath('..'); addpath('../SOM');

dataset = carregaDados('HAR', 0);

%% Configurações gerais
ptrn = 0.75;
numRodadas = 10;

% Topologia da rede
config.vizinhos = 3;
config.topologia = 'h'; %g grid; h hexagonal
config.dist = 'l'; % b boxdist; l linkdist
config.v_i = 0.1;
config.v_f = 0.001;
config.alfa_i = 0.001;
config.alfa_f = 0.001;
config.tamanho = [30 20];
config.epocas = 400;
config.K = 5;

result = som_knn(dataset, ptrn, numRodadas, config)