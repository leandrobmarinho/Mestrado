function [output] = testeBayes(modelo, dados, conf)
%TESTEBAYES Summary of this function goes here
% modelo
% dados
% conf.custo - matriz de custo
% conf.algoritmo
%   '' - bayes tradicional com risco
%   sameVar - covariancia igual, diagonal e mesma variancia (variancia média)
%   euclidean - 
%   mahalanobis1 - covariancia igual e não diagonal
%   mahalanobis2 - covariancias distintas e não diagonal
%   mahalanobis3 - covariancia igual, diagonalizada de uma não diagonal
%                 (autovetor e autovalor)

if (strcmp(conf.algoritmo, 'euclidean') == 1)
    dist = pdist2(modelo.meansX, dados.x);
    [~, posicoes] = sort(dist);
    
    output = posicoes(1,:);
elseif (strcmp(conf.algoritmo, 'mahalanobis1') == 1)
    dist = pdist2(modelo.meansX, dados.x, 'mahalanobis', modelo.covAll);
    [~, posicoes] = sort(dist);
    
    output = posicoes(1,:);
    
elseif (strcmp(conf.algoritmo, 'mahalanobis2') == 1)
        
    dist = [];
    for (i = 1 : length(modelo.aprioriClass))
        dist = [dist; pdist2(modelo.meansX(i,:), dados.x, 'mahalanobis', modelo.covs{i})];
    end
    
    [~, posicoes] = sort(dist);
    
    output = posicoes(1,:);
    
elseif (strcmp(conf.algoritmo, 'mahalanobis3') == 1)
    
    [V E] = eig(modelo.covAll);
    covariancia = V*inv(E)*V';
    
    dist = pdist2(modelo.meansX, dados.x, 'mahalanobis', covariancia);
    [~, posicoes] = sort(dist);
    
    output = posicoes(1,:);
elseif (strcmp(conf.algoritmo, 'sameVar') == 1)
    %     keyboard
    
    variancia = mean(diag(modelo.covAll.*eye(size(dados.x,2))));
    
%         diagonal = diag(modelo.covAll.*eye(size(dados.x,2)));
%         variancia = diagonal(1);
    
    covariancia = variancia*eye(size(dados.x,2));
    
    [~, posicoes] = max( (1/variancia)*modelo.meansX*dados.x' + repmat(modelo.aprioriClass', 1, size(dados.x, 1)) - ...
        1/2*repmat(sum(modelo.meansX*inv(covariancia)*modelo.meansX')', 1, size(dados.x,1)));
    
    %     [~, indY] = max( (1/2*dados.x*inv(modelo.covAll)*modelo.meansX' - ...
    %     1/2*repmat(sum(modelo.meansX*inv(modelo.covAll)*modelo.meansX'), size(dados.x,1), 1) + ...
    %    (1/2*modelo.meansX*modelo.covAll*dados.x')' +  repmat(modelo.aprioriClass, size(dados.x,1), 1) )');
    
    output = posicoes(1,:);
    
elseif (strcmp(conf.algoritmo, '') == 1)
    
    %     keyboard
    acoes = [];
    
    % Probabilidade a priori de X
    acumulator = [];
    for j = 1 : length(modelo.aprioriClass)
        acumulator(j,:) = modelo.aprioriClass(j)*mvnpdf(dados.x, modelo.meansX(j,:), modelo.covs{j})';
    end
    aprioriClassX = sum(acumulator);
    
    % Calculo do risco
    for i = 1 : length(conf.custo),
        
        acumulator = [];
        for j = 1 : length(conf.custo),
            acumulator(j,:) = (conf.custo(i, j)*(modelo.aprioriClass(j)*...
                mvnpdf(dados.x, modelo.meansX(j,:), modelo.covs{j})')./aprioriClassX);
            %                 fdpGauss(dados.x, modelo.meansX(j,:), modelo.covs{j})'./aprioriClassX);
            
        end
        acoes(i,:) = sum(acumulator);
    end
    
    [~, output] = min(acoes);
    
end

end