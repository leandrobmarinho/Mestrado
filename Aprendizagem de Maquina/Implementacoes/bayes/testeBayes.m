function [output] = testeBayes(modelo, dados, pesos)


acoes = [];
% pesos = (-1)*pesos; %Para manter o padrao de escolher o menor
% for i = 1 : length(pesos),
%     acoes(i,:) = modelo.aprioriClass(i)*pesos(i)*mvnpdf(dados.x, modelo.means(i,:), modelo.covs{i})';
% end


% Probabilidade a priori de X
acumulator = [];
for j = 1 : length(modelo.aprioriClass)
    acumulator(j,:) = modelo.aprioriClass(j)*mvnpdf(dados.x, modelo.means(j,:), modelo.covs{j})';
end
aprioriClassX = sum(acumulator);

% Calculo do risco
for i = 1 : length(pesos),
    
    acumulator = [];
    for j = 1 : length(pesos),
        acumulator(j,:) = pesos(i, j)*(modelo.aprioriClass(j)*...
            mvnpdf(dados.x, modelo.means(j,:), modelo.covs{j})'./aprioriClassX);
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