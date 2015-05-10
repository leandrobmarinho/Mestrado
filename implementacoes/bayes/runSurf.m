close all; clear all; clc; addpath('..');

dados = carregaDados('iris.data', 0);

lin = 1; col = 2;
range = [-1 1 -1 1];
conf.custo = 1 - eye(length(unique(dados.y)));
conf.algoritmo = 'euclidean';

subplot(lin, col, 1)
graficoSuperficie(range, conf, dados, [2 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('L. Sépala', 'FontSize', 14);

subplot(lin, col, 2)
graficoSuperficie(range, conf, dados, [3 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

figure
subplot(lin, col, 1)
graficoSuperficie(range, conf, dados, [4 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 2)
graficoSuperficie(range, conf, dados, [3 2])
ylabel('L. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

figure
subplot(lin, col, 1)
graficoSuperficie(range, conf, dados, [4 2])
ylabel('L. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 2)
graficoSuperficie(range, conf, dados, [4 3])
ylabel('C. Pétala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

