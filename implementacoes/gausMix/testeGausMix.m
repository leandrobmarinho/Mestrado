function [ classes, valores ] = testeGausMix( model, data )
%TESTEGAUSMIX Summary of this function goes here
%   Detailed explanation goes here

numClass = length(model.params);
% Probabilidade a priori
for j = 1 : numClass
    aprioriClassX(j,:) = model.aprioriClass(j)*gausMixPDF(model.params{j}, data.x);
end
aprioriClassX = sum(aprioriClassX, 1);

for i = 1 : numClass
    aposteriori(i, :) = (model.aprioriClass(i)*gausMixPDF(model.params{i}, data.x));
%     ./aprioriClassX
end
[valores, classes] = max(aposteriori);

end

% atrX = 3; atrY = 2;
% cmap = lines(2);
% figure
% for i=1: 2
%     plot(data.x(data.y==i, atrX), data.x(data.y==i, atrY), 'o', 'Color', cmap(i,:))
%     hold on
% end