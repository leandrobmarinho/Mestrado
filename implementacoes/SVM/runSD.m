close all; clear all; clc
addpath('..');

%% Pré-processamento
dados = carregaDados('iris2D.data', 0);

%% Superfície de decisão
% Configurações
lin = 1; col = 2;
range = [-.8 .8 -.8 .8];

conf.algoritmo = 'SVM';
conf.metodo = 'QP';
conf.fkernel = 'linear';
conf.sigma = 0.1250;
conf.paraC = 0.5;
atributos = [3 4];

subplot(lin, col, 1)
decisionSurface(range, conf, dados, atributos)
xlabel(sprintf('Atributo %d', atributos(1)), 'FontSize', 16)
ylabel(sprintf('Atributo %d', atributos(2)), 'FontSize', 16)

conf.fkernel = 'rbf';
subplot(lin, col, 2)
decisionSurface(range, conf, dados, atributos)
xlabel(sprintf('Atributo %d', atributos(1)), 'FontSize', 16)
ylabel(sprintf('Atributo %d', atributos(2)), 'FontSize', 16)