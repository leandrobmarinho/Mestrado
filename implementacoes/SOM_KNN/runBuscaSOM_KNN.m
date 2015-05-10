close all; clear all; clc; addpath('..');

load('../SOM/topologiaSOM.mat');

resultado = buscaSOMKNN( dadosTrein, dadosTeste, modelos, 1:2:7 );

save('resultadoSOMNN');