close all; clear all; clc; addpath('..');

load('../SOM/topologiaSOM.mat');

% for i = 1 : 10
%     
%     labels = unique(dadosTeste{i}.y);
%     code = zeros(length(labels), length(labels));
%     for j = 1: length(labels),
%         code(j, j) = 1;
%     end
%     
%     for j = length(labels):-1:1,
%         ind = (dadosTeste{i}.y == labels(j));
%         tam = length(find(ind==1));
%         y(ind, :) = repmat(code(j, :), tam, 1);
%     end
%     dadosTeste{i}.y = y;
%     clear y;
%     
%     labels = unique(dadosTrein{i}.y);
%     code = zeros(length(labels), length(labels));
%     for j = 1: length(labels),
%         code(j, j) = 1;
%     end
%     
%     for j = length(labels):-1:1,
%         ind = (dadosTrein{i}.y == labels(j));
%         tam = length(find(ind==1));
%         y(ind, :) = repmat(code(j, :), tam, 1);
%     end
%     dadosTrein{i}.y = y;
%     clear y;
% end
resultado = buscaRBFsom( dadosTrein, dadosTeste, modelos, [0.1 0.01 0.001] );

save('resultadoRBFsom');