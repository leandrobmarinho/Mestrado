close all; clear all; clc; addpath('..');addpath('../SOM');

%% Pré-processamento
dataset = carregaDados('iris.data', 0, 2);

%% Configurações gerais
ptrn = 0.75;
numRodadas = 10;
numFolds = 10;


%% Criando as combinações de parâmetros para a validação cruzada
param = combvec([2:1:9], [2:1:9]);
param = combvec([50:50:400], param);
param = combvec([1:2:5], param);

% Topologia da rede
config.vizinhos = 1;
config.topologia = 'g'; %g grid; h hexagonal
config.dist = 'b'; % b boxdist; l linkdist
config.v_i = 0.1;
config.v_f = 0.001;
config.alfa_i = 0.01;
config.alfa_f = 0.001;

for i = 1 : length(param)
    config.tamanho = [param(3,i) param(4,i)];
    config.epocas = param(2,i);
    config.K = param(1,i);
    params{i} = config;
end

result = som_knnVC(dataset, ptrn, numRodadas, params, numFolds)