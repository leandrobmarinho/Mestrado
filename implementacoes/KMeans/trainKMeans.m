function [model] = trainKMeans(data, conf )
% TRAINKMEANS
%   dados - Dados para treinamento.
%   k - número de clusters

if (conf.k == 1)
    model.prototypes = mean(data);
    dataset.x = data;
    dataset.y = ones(1, size(data,1));
    model.data = dataset;
    return;
end

%Seleciona os prótipos
inds = randperm(size(data,1));
prototype = data(inds(1:conf.k), :);

y = zeros(1, size(data,1));

% enquanto não estabilizar
for epoca = 1 : conf.epocas
    
    % Rotulando as amostras (Etapa E)
    [~, clusters] = sort(pdist2(prototype, data));
    yNew = clusters(1,:);
        
    if ( sum(y==yNew) == size(data,1) )
        fprintf('K-Means estabilizou na época %d\n', epoca);
        break
    end    
    y = yNew;
    
    
    % Posicionado os prototipos (Etapa M)
    for i=1: conf.k
        prototype(i, :) = mean(data(y==i, :));
    end
    

end

model.prototypes = prototype;
dataset.x = data;
dataset.y = y';
model.data = dataset;

% % Plot
% cmap = lines(conf.k);
% figure
% for i=1: conf.k
%     plot(data(y==i, 3), data(y==i, 2), 'o', 'Color', cmap(i,:))
%     hold on
% end
% plot(prototype(:,3), prototype(:,2), '*k')

end

