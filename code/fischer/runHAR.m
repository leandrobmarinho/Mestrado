close all; clear all; clc; addpath('../../../Mestrado/data/');
addpath('../../code/utils/');

data = load('../../../Mestrado/data/iris.data');
dados.x = data(:,1:4);
dados.y = data(:,5);


%% Configura??es gerais
ptrn = 0.8;
numRepet = 10;

bayes(dados, ptrn, numRepet)