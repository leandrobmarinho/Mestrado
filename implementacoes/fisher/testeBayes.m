function [classes, valores] = testeBayes(modelo, dados)
%TESTEBAYES Summary of this function goes here
% modelo
% dados

% Probabilidade a priori de X
aprioriClassX = [];
for j = 1 : length(modelo.aprioriClass)
    aprioriClassX(j,:) = modelo.aprioriClass(j)*mvnpdf(dados.x, modelo.meansX(j,:), modelo.covs{j})';
end
aprioriClassX = sum(aprioriClassX);

aposteriori = [];
for i = 1 : size(modelo.meansX,1)
    aposteriori(i, :) = (modelo.aprioriClass(i)*mvnpdf(dados.x, modelo.meansX(i,:), ...
        modelo.covs{i})');
end

[valores, classes] = max(aposteriori);

N = size(dados.x, 1);
aposteriori2 = [];
for i = 1 : size(modelo.meansX,1)
aposteriori2(i, :) = modelo.aprioriClass(i)*(log(modelo.aprioriClass(i))... -
    log(aposteriori) - 1/2 * log(det(modelo.covs{i})) - 1/2 * (dados.x(1,:) - modelo.meansX(i,:) ) * ...
    inv(modelo.covs{i}) * (dados.x(1,:) - modelo.meansX(i,:) )');
end


[valores2, classes2] = max(aposteriori2);
keyboard
% aposteriori2(i, :) = modelo.aprioriClass(i)*(log(modelo.aprioriClass(i)) - 1/2 * ...
%     log(det(modelo.covs{i})) - 1/2 * diag((dados.x - repmat(modelo.meansX(i,:), N, 1) ) * ...
%     modelo.covs{i} * (dados.x - repmat(modelo.meansX(i,:), N, 1) )'));

end