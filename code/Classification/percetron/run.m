close all; clear all; clc; addpath('..');


%% Pr?-processamento
conf.pca = 0.98;
conf.selecaoAtr = 0.1;
dataset = carregaDados('iris2D.data', 4);


%% Configura??es gerais
ptrn = 0.8;
numRodadas = 10;

config.epocas = 100;
config.alfa = 0.01;

simPerceptron(dataset, ptrn, numRodadas, config)
