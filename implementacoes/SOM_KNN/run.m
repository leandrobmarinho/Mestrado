close all; clear all; clc; addpath('..'); addpath('../SOM');

%% Carregando dados
conf.pca = 0.98; conf.selecaoAtr = 0.1;
dados = carregaDados('har', 0, conf);


%% Configurações gerais
ptrn = 0.8;
rodadas = 1;%5


%% Topologia geral da rede 
rede.vizinhos = 3; %3
rede.topologia = 'h'; %g grid; h hexagonal
rede.dist = 'l'; % b boxdist; l linkdist
rede.v_i = 0.09; %0.9
rede.v_f = 0.085; %0.85
rede.alfa_i = 0.01; % 0.01 10.1 0.01 -0.00001
rede.alfa_f = 0.01; % 0.01 0.09 0.009 0.1
rede.epocas = 200;
rede.K = 5;
rede.tamanho = [25 25];


som_knn( dados, ptrn, rodadas, rede)