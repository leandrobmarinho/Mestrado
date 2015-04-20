function [ dataset ] = carregaDados( path, tipo_saida, pca)
%CARREGADADOS Summary of this function goes here
%   path - caminho do arquivo
%   tipo_saida - 
%       [1] - [0 0 1]
%       [diferente de 1] - 3
%   pca - porcentagem dos autovalores para o PCA

%% Carregando os dados
if (strcmpi('HAR', path) == 1)
    fprintf('Carregando dados HAR...\n')    
    
    dataset.x = load('../dados/HAR/train/X_train.txt');
    dataset.x = [dataset.x; load('../dados/HAR/test/X_test.txt')];
    
    y = load('../dados/HAR/train/y_train.txt');
    y = [y; load('../dados/HAR/test/y_test.txt')];
    
else
    data = load(strcat('../dados/', path));
    dataset.x = data(:, 1:end-1);
    y = data(:, end);
    clear data;
end

%% PCA
if (pca > 0 && pca <= 1)
    [V E] = eig( cov(dataset.x) );
    [E order] = sort(diag(E), 'descend');
    V = V(:,order);
    
    sumE = cumsum(E)/sum(E);
    [~, ultimo] = max(sumE >= pca);
    V = V(:, 1:ultimo);
    
    dataset.x = dataset.x*V;
end

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

