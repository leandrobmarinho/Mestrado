close all; clear all; clc; addpath('../');

%% Pré-processamento
conf.pca = 0.98;
% conf.selecaoAtr = 0.1;
dados = carregaDados('har', 1);


%% Configurações gerais
ptrn = 0.8;
numRodadas = 5;

r = simKNN( dados, ptrn, numRodadas, 1)

atr = [1 2 3 4];
clc;printTable(1, r.metricasMedia(:, atr), std(r.metricasMedia(:, atr), [], 3), ...
    r.metricasGeralMedia(:, atr), std(r.metricasGeralMedia(:, atr), [], 3))

clc;printTable(2, r.matConfTesteMedia2)

clc;printTable(3, r.matConfPorcMedia2)