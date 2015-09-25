close all; clear all; clc; addpath('..');addpath('../SOM');

%% Pré-processamento
dataset = carregaDados('iris.data', 0);

%% Configurações gerais
ptrn = 0.75;
numRodadas = 1;

% Topologia da rede
config.vizinhos = 1;
config.topologia = 'h'; %g grid; h hexagonal
config.dist = 'l'; % b boxdist; l linkdist
config.tamanho = [4 4];
config.epocas = 200;
config.K = 3;
config.v_i = 0.1;
config.v_f = 0.05;
config.alfa_i = 0.5;
config.alfa_f = 0.01;


result = som_knn(dataset, ptrn, numRodadas, config)

somAlerta()