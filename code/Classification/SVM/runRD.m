%{
Plot os gráficos de região de decisão com vetores de suport.
%}

close all; clear all; clc; addpath('..');

%% Pré-processamento
dados = carregaDados('coluna2c.data', 4);


%% Configurações gerais
metodo = 'SMO';
fkernel = 'rbf';
atributos = [1 8];


paraC = 32; %
sigma = 32;

%% Superfície de decisão
dados.x = dados.x(:, atributos);

[dadosTrein, dadosTeste] = embaralhaDados(dados, 0.8, 2)
if (strcmp('rbf', fkernel) == 1)
    
    modelo = svmtrain(dadosTrein.x, dadosTrein.y,'kernel_function',...
        fkernel,'rbf_sigma',sigma,'boxconstraint',paraC,...
        'method',metodo,'kernelcachelimit',15000, 'ShowPlot',true);
else
    modelo = svmtrain(dadosTrein.x, dadosTrein.y,'kernel_function',...
        fkernel,'boxconstraint',paraC,'method',metodo,...
        'kernelcachelimit',15000, 'ShowPlot',true);
end

xlabel(sprintf('Atributo %d', atributos(1)), 'FontSize', 16)
ylabel(sprintf('Atributo %d', atributos(2)), 'FontSize', 16)
title(sprintf('SVM/%s/%s',metodo, fkernel), 'FontSize', 20)

%% Teste
Yh = svmclassify(modelo, dadosTeste.x);

matConf = confusionmat(dadosTeste.y, Yh);
acuracia = trace(matConf) / size(Yh,1)
