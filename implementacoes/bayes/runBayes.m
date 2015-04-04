close all; clear all; clc
addpath('..');

%% Pré-processamento
dataset = carregaDados('iris.data', 0);


%% Configurações gerais
ptrn = 0.8;
numRepet = 10;
conf.custo = 1 - eye(length(unique(dataset.y)));
conf.algoritmo = '';

% resultCOMP = bayes(dataset, ptrn, numRepet, conf)
% 
% conf.algoritmo = 'sameVar';
% resultMVAR = bayes(dataset, ptrn, numRepet, conf)
% 
% conf.algoritmo = 'euclidean';
% resultEUCLI = bayes(dataset, ptrn, numRepet, conf)
% 
% conf.algoritmo = 'mahalanobis1';
% resultMAHALA1 = bayes(dataset, ptrn, numRepet, conf)
% 
% conf.algoritmo = 'mahalanobis2';
% resultMAHALA2 = bayes(dataset, ptrn, numRepet, conf)
% 
% conf.algoritmo = 'mahalanobis3';
% resultMAHALA3 = bayes(dataset, ptrn, numRepet, conf)




%% Superfície de decisão

% lin = 2; col = 3;
% range = [-1 1 -1 1];
% conf.algoritmo = 'euclidean';
% 
% subplot(lin, col, 1)
% decisionSurface(range, conf, dataset, [2 1])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('L. Sépala', 'FontSize', 14);
% 
% subplot(lin, col, 2)
% decisionSurface(range, conf, dataset, [3 1])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
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