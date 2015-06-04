close all; clear all; clc; addpath('..');

%{
Relação entre o número de viagens de automóvel gerados a partir de uma área
e a demografia da região. Os dados demográficos e de viagem foram coletados
 a partir de zonas de análise de tráfego em New Castle County, Delaware. 

Cinco fatores demográficos são considerados: 
população, número de unidades habitacionais, de proprietários de veículos, 
renda familiar média e do emprego total.
%}


% Carrega os dados
tripdata

% Clusteriza
[C,S] = subclust([datin datout],0.5);

load('tripCluster.mat');

mean((evalfis(datin', trafficFS) - datout).^2)