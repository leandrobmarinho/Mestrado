function [classes, valores] = testeBayes(modelo, dados, conf)
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
%   bayesRej - bayesiano com rejeição
% conf.t - limiar para rejeição binária

if (strcmp(conf.algoritmo, 'euclidean') == 1)
    dist = pdist2(modelo.meansX, dados.x);
    [v, posicoes] = sort(dist);
    
    classes = posicoes(1,:);
    valores = v(1,:);
elseif (strcmp(conf.algoritmo, 'mahalanobis1') == 1)
    dist = pdist2(modelo.meansX, dados.x, 'mahalanobis', modelo.covAll);
    [v, posicoes] = sort(dist);
    
    classes = posicoes(1,:);
    valores = v(1,:); 
elseif (strcmp(conf.algoritmo, 'mahalanobis2') == 1)
        
    dist = [];
    for (i = 1 : length(modelo.aprioriClass))
        dist = [dist; pdist2(modelo.meansX(i,:), dados.x, 'mahalanobis', modelo.covs{i})];
    end
    
    [v, posicoes] = sort(dist);
    
    classes = posicoes(1,:);
    valores = v(1,:);
elseif (strcmp(conf.algoritmo, 'mahalanobis3') == 1)
    
    [V E] = eig(modelo.covAll);
    covariancia = V*inv(E)*V';
    
    dist = pdist2(modelo.meansX, dados.x, 'mahalanobis', covariancia);
    [v, posicoes] = sort(dist);
    
    classes = posicoes(1,:);
    valores = v(1,:);
elseif (strcmp(conf.algoritmo, 'sameVar') == 1)
    %     keyboard
    
    variancia = mean(diag(modelo.covAll.*eye(size(dados.x,2))));
    
%         diagonal = diag(modelo.covAll.*eye(size(dados.x,2)));
%         variancia = diagonal(1);
    
    covariancia = variancia*eye(size(dados.x,2));
    
%     [~, posicoes] = max( (1/variancia)*modelo.meansX*dados.x' + log(repmat(modelo.aprioriClass', 1, size(dados.x, 1))) - ...
%         1/2*repmat(sum(modelo.meansX*inv(covariancia)*modelo.meansX')', 1, size(dados.x,1)));
%         
%     output = posicoes(1,:);
    
    acumulator = [];
    for i = 1 : size(modelo.meansX,1)
        acumulator = [acumulator; mvnpdf(dados.x, modelo.meansX(i,:), covariancia)'*modelo.aprioriClass(i)];
    end
    [valores, classes] = max(acumulator);
    
elseif (strcmp(conf.algoritmo, '') == 1)
    
    %     keyboard
    acoes = [];
    
    try
        % Probabilidade a priori de X
        aprioriClassX = [];
        for j = 1 : length(modelo.aprioriClass)
            aprioriClassX(j,:) = modelo.aprioriClass(j)*mvnpdf(dados.x, modelo.meansX(j,:), modelo.covs{j})';
        end
        aprioriClassX = sum(aprioriClassX);
        
    catch me
        keyboard
    end
    
    % Calculo do risco    
%      for i = 1 : length(conf.custo),
%          
%          acumulator = [];
%          for j = 1 : length(conf.custo),
%              acumulator(j,:) = (conf.custo(i, j)*(modelo.aprioriClass(j)*...
%                  mvnpdf(dados.x, modelo.meansX(j,:), modelo.covs{j})')./aprioriClassX);
%          end
%          acoes(i,:) = sum(acumulator);
%      end    
%      [valores, classes] = min(acoes);


   for i = 1 : size(modelo.meansX,1)
       acoes(i, :) = (mvnpdf(dados.x, modelo.meansX(i,:), modelo.covs{i})');
   end
   [valores, classes] = max(acoes);

elseif (strcmp(conf.algoritmo, 'bayesRej') == 1)
        
	if (length(modelo.aprioriClass) ~= 2)
        error('Bayes com rejeição só é permitido com problemas binários');
    end
        
    % Probabilidade a priori de X
    aprioriClassX = [];
    for j = 1 : length(modelo.aprioriClass)
        aprioriClassX(j,:) = modelo.aprioriClass(j)*mvnpdf(dados.x, modelo.meansX(j,:), modelo.covs{j})';
    end
    aprioriClassX = sum(aprioriClassX);
    
    for i = 1 : size(modelo.meansX,1)
        acoes(i, :) = (modelo.aprioriClass(i)*mvnpdf(dados.x, modelo.meansX(i,:), ...
            modelo.covs{i})')./aprioriClassX;
    end

    [valores, classes] = max(acoes);
    classes(valores <= 0.5 + conf.t) = 0;
    
end

end