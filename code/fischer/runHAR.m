close all; clear all; clc; addpath('..');

%% Pré-processamento
conf.pca = 0.98; conf.selecaoAtr = 0.03;
dados = carregaDados('har', 0, conf);

%dados = carregaDados('iris.data', 0);


%% Configurações gerais
ptrn = 0.8;
numRepet = 10;

bayes(dados, ptrn, numRepet)