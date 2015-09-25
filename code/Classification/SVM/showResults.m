%{
Mostra os resultados das tabelas usadas no relatório
%}
clear all; close all; clc; addpath('../');

folder = 'result/';
files = dir(sprintf('%s*.mat', folder));

for i = 1 : numel(files)
    load(sprintf('%s%s', folder, files(i).name));
    
%     fprintf('& %0.2f & %0.2f & %0.1f %s\n', 100*mediaAcc, 100*desvPadr, mean(numSV), files(i).name)
    
    fprintf('& %0.2f & %0.4f & %0.4f %s\n', 100*mediaAcc, mean(tempoTreino)*1000000, mean(tempoTeste)*1000000, files(i).name)
end

%mesh(paraC, sigma, 1-reshape(Ecv{1}, length(paraC), length(sigma)))