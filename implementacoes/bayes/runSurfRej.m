close all; clear all; clc; addpath('..');

dados = carregaDados('column_2C.data', 0);
% coluna .15
% diabetes .35
% breast_cancer .25
% haberman .25


lin = 1; col = 2;
range = [-1 1 -1 1];

conf.custo = 1 - eye(length(unique(dados.y)));
conf.t = 0.15;

conf.algoritmo = 'bayesRej';

subplot(lin, col, 1)
graficoSuperficie(range, conf, dados, [1 2])
ylabel('2', 'FontSize', 14);
xlabel('1', 'FontSize', 14);

conf.algoritmo = '';

subplot(lin, col, 2)
graficoSuperficie(range, conf, dados, [1 2])
ylabel('2', 'FontSize', 14);
xlabel('1', 'FontSize', 14);

