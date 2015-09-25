close all; clear all; clc; addpath('..');

%% Carregando dados
conf.pca = 0.98;
conf.selecaoAtr = 0.1;
dados = carregaDados('har', 1, conf);


%% Configurações gerais
conf.ptrn = 0.8;
conf.treinos = 2;

%% Criando as combinações de parâmetros
%numero de neuronios na camada oculta
param = [30 100 110 500 600];
param = combvec([0.001 0.005 0.01 0.1], param);
% param = [50 100 150 200];
% param = combvec([0.001 0.01 0.1], param);


% Topologia geral da rede 
rede.maxIterations = 200;

for i = 1 : size(param,2)
    rede.L = param(2, i);
    rede.lRate = param(1, i);

    params{i} = rede;
end

conf.fileName = 'topologiaMLP';
buscaTopologiaMLP(dados, params, conf)
save(conf.fileName,'-append');