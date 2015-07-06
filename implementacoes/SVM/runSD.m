%{
Plot os gráficos de superfície de decisão.
%}

close all; clear all; clc; addpath('..');

%% Pré-processamento
dados = carregaDados('iris2D.data', 0);

%% Superfície de decisão
% Configurações
lin = 1; col = 2;
range = [-1 1 -1 1];

conf.algoritmo = 'SVM';
conf.metodo = 'QP';
conf.fkernel = 'linear';
conf.paraC = 0.0313;
atributos = [1 3];

subplot(lin, col, 1)
decisionSurface(range, conf, dados, atributos)
xlabel(sprintf('Atributo %d', atributos(1)), 'FontSize', 16)
ylabel(sprintf('Atributo %d', atributos(2)), 'FontSize', 16)
title(sprintf('SVM/%s/%s', conf.metodo, conf.fkernel), 'FontSize', 20);

conf.fkernel = 'rbf';
conf.paraC = 8;
conf.sigma = 32;
subplot(lin, col, 2)
decisionSurface(range, conf, dados, atributos)
xlabel(sprintf('Atributo %d', atributos(1)), 'FontSize', 16)
ylabel(sprintf('Atributo %d', atributos(2)), 'FontSize', 16)
title(sprintf('SVM/%s/%s', conf.metodo, conf.fkernel), 'FontSize', 20);
