close all; clear all; clc; addpath('..');

%% Carregando dados
conf.normaliza = true;
dados = carregaDados('motor.data', 1, conf);


%% Configurações gerais
conf.ptrn = 0.8;
conf.treinos = 10;

%% Criando as combinações de parâmetros
%numero de neuronios na camada oculta
param = [2 4 6 8 10];
param = combvec([0.001 0.005 0.01 0.1], param);


% Topologia geral da rede 
rede.maxIterations = 200;

for i = 1 : size(param,2)
    rede.L = param(2, i);
    rede.lRate = param(1, i);

    params{i} = rede;
end

conf.fileName = 'topologiaMLPmotor';
buscaTopologiaMLP(dados, params, conf)
save(conf.fileName,'-append');