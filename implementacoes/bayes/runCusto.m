close all; clear all; clc
addpath('..');

%% Pré-processamento
dataset = carregaDados('iris.data', 0);


%% Configurações gerais
ptrn = 0.75;
numRepet = 10;


%%
conf.custo = [0 20 20;20 0 20; 1 1 0];
% conf.custo = [0 1 50;1 0 50; 1 1 0];
conf.algoritmo = '';
resultCOMP2 = bayes2(dataset, ptrn, numRepet, conf);
resultCOMP2.confusionMatrix1
resultCOMP2.confusionMatrix2
% resultCOMP2.accMean2 >= resultCOMP2.accMean1
fprintf('%0.2f %0.2f\n', resultCOMP2.accMean2, resultCOMP2.accMean1)


%%
% conf.custo = 1 - eye(length(unique(dataset.y)));
% conf.algoritmo = '';
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



% http://www.mathworks.com/help/stats/probability-distributions-used-for-multivariate-modeling.html
% http://www.mathworks.com/help/stats/multivariate-normal-distribution.html

% Superfície de decisão

lin = 2; col = 3;
range = [-1 1 -1 1];
conf.algoritmo = '';

subplot(lin, col, 1)
decisionSurface(range, conf, dataset, [2 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('L. Sépala', 'FontSize', 14);

subplot(lin, col, 2)
decisionSurface(range, conf, dataset, [3 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

subplot(lin, col, 3)
decisionSurface(range, conf, dataset, [4 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 4)
decisionSurface(range, conf, dataset, [3 2])
ylabel('L. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

subplot(lin, col, 5)
decisionSurface(range, conf, dataset, [4 2])
ylabel('L. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 6)
decisionSurface(range, conf, dataset, [4 3])
ylabel('C. Pétala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);


%%
figure
conf.custo = 1 - eye(length(unique(dataset.y)));
lin = 2; col = 3;
range = [-1 1 -1 1];
conf.algoritmo = '';

subplot(lin, col, 1)
decisionSurface(range, conf, dataset, [2 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('L. Sépala', 'FontSize', 14);

subplot(lin, col, 2)
decisionSurface(range, conf, dataset, [3 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

subplot(lin, col, 3)
decisionSurface(range, conf, dataset, [4 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 4)
decisionSurface(range, conf, dataset, [3 2])
ylabel('L. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

subplot(lin, col, 5)
decisionSurface(range, conf, dataset, [4 2])
ylabel('L. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 6)
decisionSurface(range, conf, dataset, [4 3])
ylabel('C. Pétala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);