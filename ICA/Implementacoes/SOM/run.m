close all; clear all; clc;

%% Carregando os dados
data = load('../iris.data');
dataset.x = data(:, 1:2); %MUDAR PARA OS 4
dataset.y = data(:, 5:7);
clear data;

%% Normalizando os dados
[lin, ~] = size(dataset.x);

minimo = min(dataset.x);
maximo = max(dataset.x);
media = mean(dataset.x);
minRep = repmat(minimo, lin, 1);
maxRep = repmat(maximo, lin, 1);
mediaRep = repmat(media, lin, 1);
dataset.x = (dataset.x - mediaRep)./(maxRep - minRep);




%% Configurações gerais
ptrn = 0.8;
numRepet = 1;

% Topologia da rede
config.vizinhos = 1;
config.topologia = 'g'; %g grid; h hexagonal
config.dist = 'b'; % b boxdist; l linkdist
config.tamanho = [8 8];
config.epocas = 500;

result = som(dataset, ptrn, numRepet, config);