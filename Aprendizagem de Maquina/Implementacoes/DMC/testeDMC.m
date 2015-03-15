function [classesCentr] = testeDMC(centroides, dadosTeste)

%  keyboard

%% Calcula distancia entre os dados de treinamento e os de teste
dist = pdist2(centroides.x, dadosTeste.x);
[~, posicoes] = sort(dist);

classesCentr = centroides.y(posicoes(1,:), :);

end