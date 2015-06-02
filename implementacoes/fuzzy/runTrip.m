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
datin = datin(:,[1 4]);


load('trip.mat');
fuzzy(trip);

mean((evalfis(datin', trip) - datout).^2)