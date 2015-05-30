close all; clear all; clc; addpath('..');

% Carrega os dados
tripdata

% Clusteriza
[C,S] = subclust([datin datout],0.5);


myfis=genfis2(datin,datout,0.5);

mean(abs(evalfis(datin', myfis) - datout))