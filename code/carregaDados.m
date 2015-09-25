function [ dataset ] = carregaDados( path, tipo_saida, conf, varargin)
%CARREGADADOS Summary of this function goes here
%   path - caminho do arquivo
%   tipo_saida -
%       [4] - 1; -1; 1 (apenas classificação binária)
%       [3] - [-0.98 -0.98 0.98]
%       [2] - [-1 -1 1]
%       [1] - [0 0 1]
%       [outro numero] - O direto da base. Geralmente um número.
%   conf.pca - porcentagem dos autovalores para o PCA.
%   conf.selecaoAtr - taxa de selecao atributos pela variancia
%   conf.normaliza - (true) normaliza os dados

if nargin < 2 || nargin > 3
    error('Número de argumentos inválidos');
end

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

%% Selecao de atributos
if (exist('conf', 'var') == 1 && isfield(conf, 'selecaoAtr') == 1)
    % 0.015 0.1 0.45 0.07 0.03
    % bayes - 0.03
    % som - 0.1
    
    ind = var(dataset.x) >= conf.selecaoAtr;
    dataset.x = dataset.x(:, ind);
    fprintf('Num atributos depois da SelecaoAtri %d\n', size(dataset.x, 2));
end

%% Normalizando os dados
if ((strcmpi('HAR', path) == 0) && (exist('conf', 'var') == 0) || ...
        exist('conf', 'var') == 1 && isfield(conf, 'normaliza') == 1 ...
        && conf.normaliza == true)
    dataset.x = normalizaDados(dataset.x, 1);
end

%% PCA
if (exist('conf', 'var') == 1 && isfield(conf, 'pca') == 1)
    
    [V E] = eig( cov(dataset.x) );
    [E order] = sort(diag(E), 'descend');
    V = V(:,order);
    
    sumE = cumsum(E)/sum(E);
    [~, ultimo] = max(sumE >= conf.pca);
    V = V(:, 1:ultimo);
    
    dataset.x = dataset.x*V;
    
    fprintf('Num atributos depois do PCA %d\n', size(dataset.x, 2));
end

switch tipo_saida
    case 1
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
        
    case 2
        %% pre-processing / 1-of-S output encoding scheme
        labels = unique(y);
        code = -1*ones(length(labels), length(labels));
        for j = 1: length(labels),
            code(j, j) = 1;
        end
        
        for j = length(labels):-1:1,
            ind = (y == labels(j));
            tam = length(find(ind==1));
            dataset.y(ind, :) = repmat(code(j, :), tam, 1);
        end
        
    case 3
        labels = unique(y);
        code = -0.98*ones(length(labels), length(labels));
        for j = 1: length(labels),
            code(j, j) = 0.98;
        end
        
        for j = length(labels):-1:1,
            ind = (y == labels(j));
            tam = length(find(ind==1));
            dataset.y(ind, :) = repmat(code(j, :), tam, 1);
        end
        
    case 4
        labels = unique(y);
        if (length(labels) ~= 2)
            error('Apenas classificação binária!');
        end
        dataset.y(y == labels(1)) = -1;
        dataset.y(y == labels(2)) = 1;
        dataset.y = dataset.y';

    otherwise
        dataset.y = y;
end

end

