close all; clear all; clc; addpath('..');

%% Carregando dados
conf.pca = 0.98;
conf.selecaoAtr = 0.1;
dados = carregaDados('har', 1, conf);


%% Configurações gerais
conf.ptrn = 0.8;
conf.treinos = 5;

%% Criando as combinações de parâmetros
%numero de neuronios na camada oculta
param = 10 : 50 : 1000;
param = combvec([1 0.1 0.01 0.001], param);


% Topologia geral da rede 

for i = 1 : size(param,2)
    
    rede.nOcultos = param(2, i);
    rede.gamma = param(1, i);
    
    params{i} = rede;
end

conf.fileName = 'topologiaRBF';
buscaTopologiaRBF(dados, params, conf)
save(conf.fileName,'-append');