close all; clear all; clc; addpath('..');

%% Pré-processamento
i = 1;
for limiar = 0.01 : 0.01 : 0.5 
conf.pca = 0.98; conf.selecaoAtr = limiar; %0.03
dataset = carregaDados('har', 0, conf);


%% Configurações gerais
ptrn = 0.75;
numRepet = 10;

conf.custo = 1 - eye(length(unique(dataset.y)));
conf.algoritmo = '';
r{i} = bayes(dataset, ptrn, numRepet, conf);
acuracias(i) = r{i}.accMean;
numAtr(i) = size(dataset.x, 2);
i = i + 1;
end