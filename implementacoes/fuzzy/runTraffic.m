close all; clear all; clc; addpath('..');

% Carrega os dados
tripdata

% Clusteriza
[C,S] = subclust([datin datout],0.5);

load('traffic.mat');

mean((evalfis(datin', trafficFS) - datout).^2)