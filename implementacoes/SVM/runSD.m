close all; clear all; clc
addpath('..');

%% Pré-processamento
dados = carregaDados('column_2C.data', 0);

%% Superfície de decisão
% Configurações
lin = 1; col = 2;
range = [-.8 .8 -.8 .8];

conf.algoritmo = 'SVM';
conf.metodo = 'QP';
conf.fkernel = 'linear';
conf.paraC = 2;
atributos = [3 4];

subplot(lin, col, 1)
decisionSurface(range, conf, dados, atributos)
xlabel(sprintf('Atributo %d', atributos(1)), 'FontSize', 16)
ylabel(sprintf('Atributo %d', atributos(2)), 'FontSize', 16)
title(sprintf('SVM/%s/%s', conf.metodo, conf.fkernel), 'FontSize', 20);

conf.fkernel = 'rbf';
conf.paraC = 8;
conf.sigma = 2;
subplot(lin, col, 2)
decisionSurface(range, conf, dados, atributos)
xlabel(sprintf('Atributo %d', atributos(1)), 'FontSize', 16)
ylabel(sprintf('Atributo %d', atributos(2)), 'FontSize', 16)
title(sprintf('SVM/%s/%s', conf.metodo, conf.fkernel), 'FontSize', 20);
