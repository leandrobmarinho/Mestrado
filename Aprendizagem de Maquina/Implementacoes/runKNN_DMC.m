close all; clear all; clc
addpath('K-NN'); addpath('DMC');


%% Carregando os dados
data = load('iris.data');
dataset.x = data(:, 1:4);
dataset.y = data(:, 5:7);
clear data;


%% 
ptrn = 0.8;
numRepet = 10;

result = knn_dmc(dataset, 9, ptrn, numRepet);
result.accuracyDMC