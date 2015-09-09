function [modelo] = trainBayes(dados)

N = size(dados.x, 1);
meansX = [];
meansY = [];

classes = unique(dados.y);
for i = 1 : length(unique(dados.y)),

    % Seleciona apenas as amostras com a classe pretendida
    indx = find(dados.y == classes(i));keyboard;
    if not(isempty(indx))
        meansX = [meansX; mean(dados.x(indx, :))];
        meansY = [meansY; classes(i)];
    end
    
    
    modelo.aprioriClass(i) = length(indx) / N;
    
    covs{i} = cov(dados.x(indx, :));
    if (rcond(covs{i}) < 1e-12)
        covs{i} = covs{i} + 0.01*eye(size(dados.x,2));
    end
end


modelo.meansX = meansX;
modelo.covs = covs;

modelo.covAll = cov(dados.x);
if (rcond(modelo.covAll) < 1e-12)
    modelo.covAll = modelo.covAll + 0.01*eye(size(dados.x,2))
end

end