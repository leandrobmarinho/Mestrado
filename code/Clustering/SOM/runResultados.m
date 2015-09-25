close all; clear all; clc; addpath('..');

load('topologiaSOMTudo');

%% Plotando os erros de treinamento

for indTam = 1 : size(treinErrosQuant, 2)
    
    figure
    for i = 1 : size(treinErrosQuant, 1)
        plot(1:1:size(treinErrosQuant{i,indTam}, 2), treinErrosQuant{i,indTam}, '-b')
        hold on
    end
    
    mediaErro = mean(cell2mat(treinErrosQuant(:, indTam)), 1);
    plot(1:1:length(mediaErro), mediaErro, '-r')
    
%     varErro = var(cell2mat(treinErrosQuant(:, indTam)), 1);
%     plot(1:1:length(varErro), varErro, '-k')
    
    xlabel('Época', 'FontSize', 14);
    ylabel('Erro de Quantização', 'FontSize', 14);
end