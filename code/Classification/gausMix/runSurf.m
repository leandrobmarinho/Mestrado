close all; clear all; clc; addpath('..'); addpath('../KMeans');

dados = carregaDados('iris2D.data', 0);

conf.epocas = 200;
conf.threshold = 10;
conf.Ks = [2 1];
conf.algoritmo = 'mixGaus';

lin = 1; col = 2;
range = [-1 1 -1 1];

subplot(lin, col, 1)
graficoSuperficie(range, conf, dados, [3 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

conf.custo = 1 - eye(length(unique(dados.y)));
conf.algoritmo = '';

subplot(lin, col, 2)
graficoSuperficie(range, conf, dados, [3 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

% subplot(lin, col, 1)
% graficoSuperficie(range, conf, dados, [2 1])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('L. Sépala', 'FontSize', 14);
% 
% subplot(lin, col, 2)
% graficoSuperficie(range, conf, dados, [3 1])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% figure
% subplot(lin, col, 1)
% graficoSuperficie(range, conf, dados, [4 1])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 2)
% graficoSuperficie(range, conf, dados, [3 2])
% ylabel('L. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% figure
% subplot(lin, col, 1)
% graficoSuperficie(range, conf, dados, [4 2])
% ylabel('L. Sépala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 2)
% graficoSuperficie(range, conf, dados, [4 3])
% ylabel('C. Pétala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);

