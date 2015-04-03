function [modelo] = trainBayes(dados)

N = size(dados.x, 1);
meansX = [];
meansY = [];

for l = 1 : length(unique(dados.y)),

    % Seleciona apenas as amostras com a classe pretendida
    indx = find(dados.y == l);
    if not(isempty(indx))
        meansX = [meansX; mean(dados.x(indx, :))];
        meansY = [meansY; l];
    end
    
    
    modelo.aprioriClass(l) = length(indx) / N;
    
    covs{l} = cov(dados.x(indx, :));
    if (rcond(covs{l}) < 1e-12)
        covs{l} = covs{l} + 0.01*eye(size(dados.x,2));
    end
end


modelo.meansX = meansX;
modelo.covs = covs;

modelo.covAll = cov(dados.x);
if (rcond(modelo.covAll) < 1e-12)
    modelo.covAll = modelo.covAll + 0.01*eye(size(dados.x,2))
else
    
end

end