function [ modelo ] = trainPzWin( dados )
%TRAINPZWIN Summary of this function goes here
%   Detailed explanation goes here

N = size(dados.x, 1);
classes = unique(dados.y);

for i = 1 : length(classes),

    % Seleciona apenas as amostras com a classe pretendida
    indx = find(dados.y == classes(i));
    if not(isempty(indx))
        dadosTrn.x = dados.x(indx, :);
        dadosTrn.y = dados.y(indx, :);
        dadosTrain{i} = dadosTrn;
    end
    
    
    modelo.aprioriClass(i) = length(indx) / N;
    
end

modelo.dadosTrain = dadosTrain;

end

