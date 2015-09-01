close all; clear all; clc; addpath('..');


%% Pré-processamento
conf.pca = 0.98;
conf.selecaoAtr = 0.1;
dataset = carregaDados('iris2D.data', 4);


%% Configurações gerais
ptrn = 0.8;
numRodadas = 10;

config.epocas = 100;
config.alfa = 0.01;

perceptron(dataset, ptrn, numRodadas, config)
