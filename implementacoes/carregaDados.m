function [ dataset ] = carregaDados( path, tipo_saida)
%CARREGADADOS Summary of this function goes here
%   Detailed explanation goes here

%% Carregando os dados
if (strcmpi('HAR', path) == 1)
    fprintf('Carregando dados HAR...\n')
    
    
    %%Tenta uma selecao de atributos
    [col, desc] = textread('../dados/HAR/features.txt', '%d %s');
    colunas = [];
    for i = 1 : length(desc)
        
        if ( isempty( findstr(desc{i}, 'std()')) && isempty( findstr(desc{i}, 'min()')) ...
                && isempty( findstr(desc{i}, 'max()')))
            colunas = [colunas; col(i)];
        end
        
    end
    
    
    %%
    y = load('../dados/HAR/test/y_test.txt');
    data = load('../dados/HAR/test/X_test.txt');
    data = data(:, colunas);
    
    prc = 0.3;
    ys = []; xs = [];
    for i = 1 : length(unique(y))
        
        ind = find(y == i);
        
        tamClasse = length(ind);
        limite = floor(prc*tamClasse);
        ind = ind(randperm(tamClasse));
        
        ys = [ys; y(ind(1:limite), :)];
        xs = [xs; data(ind(1:limite), :)];
        
    end
    y = ys;
    dataset.x = xs;
    
    
%     dataset.x = [data; load('../dados/HAR/train/X_train.txt')];
%     y = [data; load('../dados/HAR/train/y_train.txt')];
    
else
    data = load(strcat('../dados/', path));
    dataset.x = data(:, 1:end-1);
    y = data(:, end);
    
end
clear data;

%% Normalizando os dados
if (strcmpi('HAR', path) == 0)
    dataset.x = normalizaDados(dataset.x, 1);
end

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

