close all; clear all; clc; addpath('..');

%% Carregando dados
dados = carregaDados('har', 0, 0.98);


%% Configurações gerais
conf.ptrn = 0.8;
conf.treinos = 2;

%% Criando as combinações de parâmetros
%numero de neuronios na camada oculta
param = [100 10 15 20 25 30 50];

% Topologia geral da rede 
config.maxIterations = 100;
config.lRate = 0.05;

for i = 1 : size(param,2)
    config.L = [param(i) param(i)];
    params{i} = rede;
end

buscaTopologiaMLP(dados, params, conf)
save('topologiaSOM','-append');