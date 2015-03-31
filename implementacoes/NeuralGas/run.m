close all; clear all; clc;
addpath('..');

%% Carregando os dados
data = load('../iris.data');
dataset.x = data(:, 1:4);
dataset.y = data(:, 5:7);
clear data;

%% Normalizando os dados
dataset.x = normalizaDados(dataset.x, 1);

%% Configurações gerais
ptrn = 0.75;
numRepet = 4;

config.numNeur = 40;
config.epocas = 500;

result = neuralGas(dataset, ptrn, numRepet, config)


%% Plotando o boxplot
rotulos = [];
for i = 1:numRepet
    rotulos = [rotulos; 'Neural-Gas Teste'];
end
for i = 1:numRepet
    rotulos = [rotulos; 'Neural-Gas Train'];
end
valores = [result.erroTeste result.erroTrain];
boxplot(valores', rotulos);

ylabel('Erro de quantização', 'FontSize', 12)