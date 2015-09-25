clear all; close all; clc; p = path; path(p, '../'); path(p, '../utils');

%% General configurations
numRep = 2;
nameImgs = 'real_gopro';
k = 1;
path = '/Users/leandrobm/Documents/robohomegopro/';
% path = '../../../../Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/';

%% Load the images
load(sprintf('../dados/desc_%s', nameImgs));
data.imgsName = imgs;
data.labels = labels;

% Initializes variables
numClass = length(unique(labels));
matConfPorc = zeros(numClass,numClass,numRep);
metrics = zeros(numClass, numClass, numRep);
generalMetrics = zeros(numRep, 6);
confMatTest = zeros(numClass, numClass, numRep);
timeTest = zeros(1, numRep);
%% Steps
for i = 1 : numRep
    %% Shuffle the imagens
    [treinData, testData] = shuffleImgs(data, k);
    
    %% Test
    fprintf('SURF - step %d.\n', i);
    tic
    [Y, t] = testSURF(treinData, testData, k, path);
    timeTest(i) = mean(t);
    confMatTest(:,:,i) = confusionmat(testData.y', Y');
    
    
    %% Metrics
    matConfPorc(:,:,i) = (confMatTest(:,:,i)./length(testData.labels)).*100;
    [metrics(:,:,i), generalMetrics(i,:)] = metricasMatConf(confMatTest(:,:,i));
    
    save(sprintf('surf_gray_%s', nameImgs));
end

% Resultado geral
result.metricasGeralMedia = mean(generalMetrics);

result.matConfTeste = confMatTest;
result.matConfPorc = matConfPorc;
result.metricas = metrics;
result.metricasGeral = generalMetrics;

% Procura a matriz de confusão mais próxima da acc média
acc = generalMetrics(:,end);
mediaAcc = mean(acc);
[~, pos] = sort( abs ( mediaAcc - acc) );

result.matConfTesteMedia2 = confMatTest(:,:,pos(1));
result.stdAcc = std(acc);

result.tempoTeste = timeTest;

save(sprintf('surf_gray_%s', nameImgs));

path(p);