close all; clear all; clc
addpath('..');

%% Carregando os dados
data = load('../iris.data');
dataset.x = data(:, 1:4);
dataset.y = data(:, 5:7);
clear data;

%% Normalizando os dados
% [lin, ~] = size(dataset.x);
% 
% minimo = min(dataset.x);
% maximo = max(dataset.x);
% media = mean(dataset.x);
% minRep = repmat(minimo, lin, 1);
% maxRep = repmat(maximo, lin, 1);
% mediaRep = repmat(media, lin, 1);
% dataset.x = (dataset.x - mediaRep)./(maxRep - minRep);
% 
keyboard

%% Configurações gerais
ptrn = 0.8;
numRepet = 10;
custo = [0 1 1; 1 0 1; 1 1 0];

resultBayes = bayes(dataset, ptrn, numRepet, custo);


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