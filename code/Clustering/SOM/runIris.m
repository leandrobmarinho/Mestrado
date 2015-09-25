close all; clear all; clc; addpath('..');

%% Pré-processamento
dataset = carregaDados('iris.data', 0);

%% Configurações gerais
ptrn = 0.75;
numRepet = 10;

% Topologia da rede
config.vizinhos = 1;
config.topologia = 'g'; %g grid; h hexagonal
config.dist = 'b'; % b boxdist; l linkdist
config.tamanho = [9 3];
config.epocas = 200;

config.v_i = 0.1;
config.v_f = 0.01;
config.alfa_i = 0.1;
config.alfa_f = 0.01;

result = som(dataset, ptrn, numRepet, config)


%% Plotando o boxplot
rotulos = [];
for i = 1:numRepet
    rotulos = [rotulos; 'Erro Teste'];
end
for i = 1:numRepet
    rotulos = [rotulos; 'Erro Train'];
end
valores = [result.erroTeste result.erroTrain];
boxplot(valores', rotulos);

ylabel('Erro de quantização', 'FontSize', 14)