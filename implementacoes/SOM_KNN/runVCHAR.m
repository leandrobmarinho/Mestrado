close all; clear all; clc; addpath('..');addpath('../SOM');

%% Pré-processamento
dataset = carregaDados('iris.data', 0);

%% Configurações gerais
ptrn = 0.75;
numRodadas = 10;
numFolds = 10;


%% Criando as combinações de parâmetros para a validação cruzada
% param = combvec([1:1:8], [1:1:8]);
% param = combvec([10:40:500], param);
% param = combvec([1:2:15], param);
param = combvec([15:5:30], [15:5:30]);
param = combvec([200:100:800], param);
param = combvec([3:2:7], param);

% Topologia da rede
config.vizinhos = 3;
config.topologia = 'h'; %g grid; h hexagonal
config.dist = 'l'; % b boxdist; l linkdist
config.v_i = 0.1;
config.v_f = 0.001;
config.alfa_i = 0.001; % 0.1
config.alfa_f = 0.001;


for i = 1 : length(param)
    config.tamanho = [param(3,i) param(4,i)];
    config.epocas = param(2,i);
    config.K = param(1,i);
    params{i} = config;
end


result = som_knnVC(dataset, ptrn, numRodadas, params, numFolds)