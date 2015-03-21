function [output] = testeBayes(modelo, dados, custo, tipo)

keyboard
if (strcmp(tipo, 'euclidean') == 1)
    dist = pdist2(modelo.meansX, dados.x);
    [~, posicoes] = sort(dist);
    
    output = modelo.meansY(posicoes(1,:), :);
    
elseif (strcmp(tipo, 'mahalanobis') == 1)
    dist = [];
    for i = 1 : size(modelo.meansX,1)
        dist = [dist; pdist2(modelo.meansX(i,:), dados.x, tipo, modelo.covs{i})];
    end
    
    [~, posicoes] = sort(dist);
    
    output = modelo.meansY(posicoes(1,:), :);
    
elseif (strcmp(tipo, 'sameVar') == 1)
    
elseif (strcmp(tipo, '') == 1)
    
    
    acoes = [];
    custo = (-1)*custo; %Para manter o padrao de escolher o menor
    for i = 1 : length(custo),
        acoes(i,:) = modelo.aprioriClass(i)*custo(i)*mvnpdf(dados.x, modelo.meansX(i,:), modelo.covs{i})';
    end
    
    
    % Probabilidade a priori de X
    acumulator = [];
    for j = 1 : length(modelo.aprioriClass)
        acumulator(j,:) = modelo.aprioriClass(j)*mvnpdf(dados.x, modelo.meansX(j,:), modelo.covs{j})';
    end
    aprioriClassX = sum(acumulator);
    
    % Calculo do risco
    for i = 1 : length(custo),
        
        acumulator = [];
        for j = 1 : length(custo),
            acumulator(j,:) = custo(i, j)*(modelo.aprioriClass(j)*...
                mvnpdf(dados.x, modelo.meansX(j,:), modelo.covs{j})'./aprioriClassX);
        end
        acoes(i,:) = sum(acumulator);
    end
    
    [~, indY] = min(acoes);
    
    
    %% Transforma 1 em [1 0 0], 2 em [0 1 0], ...
    labels = unique(indY);
    code = zeros(length(labels), length(labels));
    for j = 1: length(labels),
        code(j, j) = 1;
    end
    
    for j = length(labels):-1:1,
        ind = (indY == labels(j));
        tam = length(find(ind==1));
        output(ind, :) = repmat(code(j, :), tam, 1);
    end
    
end

end