close all; clear all; clc; addpath('..');

%% Pré-processamento
dados = carregaDados('column_2C.data', 4);



%% Configurações gerais
metodo = 'SMO';
fkernel = 'linear';
atributos = [3 4];
sigma = 4;
paraC = 4;

dados.x = dados.x(:, atributos);
if (strcmp('rbf', fkernel) == 1)

    modelo = svmtrain(dados.x, dados.y,'kernel_function',...
        fkernel,'rbf_sigma',sigma,'boxconstraint',paraC,...
        'method',metodo,'kernelcachelimit',15000, 'ShowPlot',true);
else
    modelo = svmtrain(dados.x, dados.y,'kernel_function',...
        fkernel,'boxconstraint',paraC,'method',metodo,...
        'kernelcachelimit',15000, 'ShowPlot',true);
end