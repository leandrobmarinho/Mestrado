close all; clear all; clc
addpath('..');

%% Carregando os dados
data = load('../iris.data');
dataset.x = data(:, 1:4);
dataset.y = data(:, 5:7);
clear data;


%% Configurações gerais
ptrn = 0.8;
numRepet = 10;

resultBayes = bayes(dataset, ptrn, numRepet);


%% Superfície de decisão

lin = 2;
col = 3;
K = 0;

alg = 'bayes';
subplot(lin, col, 1)
decisionSurface([0 6 3 9], alg, dataset, K, [2 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('L. Sépala', 'FontSize', 14);

subplot(lin, col, 2)
decisionSurface([0 8 3 9], alg, dataset, K, [3 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

subplot(lin, col, 3)
decisionSurface([-1 5 -1 9], alg, dataset, K, [4 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 4)
decisionSurface([-2 8 -1 9], alg, dataset, K, [3 2])
ylabel('L. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

subplot(lin, col, 5)
decisionSurface([-2 8 1 5], alg, dataset, K, [4 2])
ylabel('L. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 6)
decisionSurface([-2 8 -1 9], alg, dataset, K, [4 3])
ylabel('C. Pétala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);