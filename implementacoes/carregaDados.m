function [ dataset ] = carregaDados( path, tipo_saida)
%CARREGADADOS Summary of this function goes here
%   Detailed explanation goes here

%% Carregando os dados
data = load(strcat('../dados/', path));
dataset.x = data(:, 1:end-1);
y = data(:, end);
clear data;

%% Normalizando os dados
dataset.x = normalizaDados(dataset.x, 1);

if (tipo_saida == 1)
    %% pre-processing / 1-of-S output encoding scheme
    labels = unique(y);
    code = zeros(length(labels), length(labels));
    for j = 1: length(labels),
        code(j, j) = 1;
    end
    
    for j = length(labels):-1:1,
        ind = (y == labels(j));
        tam = length(find(ind==1));
        dataset.y(ind, :) = repmat(code(j, :), tam, 1);
    end
else
    dataset.y = y;
end

end

