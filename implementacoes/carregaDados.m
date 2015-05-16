function [ dataset ] = carregaDados( path, tipo_saida, conf, varargin)
%CARREGADADOS Summary of this function goes here
%   path - caminho do arquivo
%   tipo_saida - 
%       [1] - [0 0 1]
%       [diferente de 1] - 3
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

