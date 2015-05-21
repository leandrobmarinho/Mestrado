close all; clear all; clc
addpath('..');

%% Pré-processamento
dataset = carregaDados('column_2C.data', 0);

%% Superfície de decisão
% Configurações
lin = 1; col = 2;
range = [-1 1 -1 1];
conf.algoritmo = 'bayesRej';
conf.t = 0.15;

subplot(lin, col, 1)
decisionSurface(range, conf, dataset, [2 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('L. Sépala', 'FontSize', 14);

subplot(lin, col, 2)
decisionSurface(range, conf, dataset, [3 5])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

% subplot(lin, col, 3)
% decisionSurface(range, conf, dataset, [4 1])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 4)
% decisionSurface(range, conf, dataset, [3 2])
% ylabel('L. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 5)
% decisionSurface(range, conf, dataset, [4 2])
% ylabel('L. Sépala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 6)
% decisionSurface(range, conf, dataset, [4 3])
% ylabel('C. Pétala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);