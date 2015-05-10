close all; clear all; clc; addpath('..');

%% Carregando dados
dados = carregaDados('har', 0, 0.98);


%% Configurações gerais
conf.ptrn = 0.8;
conf.treinos = 2;

%% Criando as combinações de parâmetros
param = [5 10 15 20 25 30 50];
% param = [3 5 8 10 15 20 25 30 35 40 45 50 80];

% Topologia geral da rede 
rede.vizinhos = 3;
rede.topologia = 'h';
rede.dist = 'l';
rede.v_i = 0.09;
rede.v_f = 0.085;
rede.alfa_i = 0.01;
rede.alfa_f = 0.01;
rede.epocas = 200;

for i = 1 : size(param,2)
    rede.tamanho = [param(i) param(i)];
    params{i} = rede;
end

buscaTopologiaSOM(dados, params, conf)
save('topologiaSOM','-append');