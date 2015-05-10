close all; clear all; clc; addpath('..');addpath('../SOM');

%% Carregando dados
dados = carregaDados('har', 0, 0.98);

%% Configurações gerais
conf.ptrn = 0.8;
conf.treinos = 8;

%% Criando as combinações de parâmetros para a validação cruzada

param = [5 10 15 20 25 30 50]; %[10 15 20 25]
param = combvec(1:2:7, param);

% Topologia geral da rede 
rede.vizinhos = 3; %3
rede.topologia = 'h'; %g grid; h hexagonal
rede.dist = 'l'; % b boxdist; l linkdist
rede.v_i = 0.09; %0.9
rede.v_f = 0.085; %0.85
rede.alfa_i = 0.01; % 0.01 10.1 0.01 -0.00001
rede.alfa_f = 0.01; % 0.01 0.09 0.009 0.1
rede.epocas = 200;

for i = 1 : size(param,2)
    rede.tamanho = [param(2,i) param(2,i)];
    rede.K = param(1,i);
    params{i} = rede;
end

buscaTopologiaSOMKNN(dados, params, conf)
save('topologiaSOMKNN','-append');