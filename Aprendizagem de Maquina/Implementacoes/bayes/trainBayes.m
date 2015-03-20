function [modelo] = trainBayes(dados)

N = length(dados.x);
means = [];

for i = 1 : length(dados.y(1, :)),
    mascara = zeros(1, length(dados.y(i, :)));
    mascara(i) = 1;
    
    % Seleciona apenas as amostras com a classe pretendida
    indx = find(mascara * dados.y');
    if not(isempty(indx))
        means = [means; mean(dados.x(indx, :))];
    end
    
    
    modelo.aprioriClass(i) = length(indx) / N;
%     covs{i} = cov(dados.x(indx, :));
    covs{i} = cov(dados.x(indx, :)) + 10^-10*eye(size(dados.x,2));
end


modelo.means = means;
modelo.covs = covs;

end