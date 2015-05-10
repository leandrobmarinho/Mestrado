close all; clear all; clc; addpath('..');

%% Pré-processamento
conf.pca = 0.98; conf.selecaoAtr = 0.03;
dataset = carregaDados('har', 0, conf);


%% Configurações gerais
ptrn = 0.75;
numRepet = 20;

conf.custo = 1 - eye(length(unique(dataset.y)));
conf.algoritmo = '';
resultCOMP = bayes(dataset, ptrn, numRepet, conf);