function [model] = trainKMeans(data, k, epocas, varargin )
% TRAINKMEANS
%   dados - Data to train.
%   k - number of clusters

if not(exist('epocas', 'var'))
    epocas = 200;
end

if (k == 1)
    model.prototypes = mean(data);
    dataset.x = data;
    dataset.y = ones(1, size(data,1));
    model.data = dataset;
    return;
end

% Seleciona os prototipos
inds = randperm(size(data,1));
prototype = data(inds(1:k), :);

y = zeros(1, size(data,1));

% enquanto nao estabilizar
for epoca = 1 : epocas
    
    % Rotulando as amostras (Etapa E)
    [~, clusters] = sort(pdist2(prototype, data));
    yNew = clusters(1,:);
        
    if ( sum(y==yNew) == size(data,1) )
        fprintf('K-Means estabilizou na epoca %d\n', epoca);
        break
    end    
    y = yNew;
    
    
    % Posicionado os prototipos (Etapa M)
    for i=1: k
        prototype(i, :) = mean(data(y==i, :));
    end
    

end

model.prototypes = prototype;
dataset.x = data;
dataset.y = y';
model.data = dataset;

end

