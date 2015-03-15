function [output] = testeBayes(modelo, dados, pesos)


acoes = [];

% pesos = (-1)*pesos; %Para manter o padrao de escolher o menor
% for i = 1 : length(pesos),
%     acoes(i,:) = modelo.aprioriClass(i)*pesos(i)*mvnpdf(dados.x, modelo.means(i,:), modelo.covs{i})';
% end


for i = 1 : length(pesos),
    
    acumulator = [];
    for j = 1 : length(pesos),
        if (i ~= j)
            acumulator(j,:) = pesos(j)*modelo.aprioriClass(j)*mvnpdf(dados.x, modelo.means(j,:), modelo.covs{j})';
        end
    end
    acoes(i,:) = sum(acumulator);
end

[~, indY] = min(acoes);



%% Transforma 1 em [1 0 0]
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