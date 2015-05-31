close all; clear all; clc; addpath('..');

load('compraInternet');
fuzzy(compraInternet);

evalfis([60 4], compraInternet)