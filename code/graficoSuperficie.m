function [ ] = graficoSuperficie( range, conf, data, atr)
%GRAFICOSUPERFICIE Summary of this function goes here
%   Detailed explanation goes here
% range - intervalo do grafico, se vazio será calculado
% conf.algoritmo
%   DMC
%   KNN
%   bayes
%   janelaParzen
% 
% dados - base de dados
% atributos - atributos para plotar

%% Seleciona os atributos
data.x = data.x(:, atr);

%% Calcula o range
if (isempty(range)) 
    range = [min(data.x(:,1)) max(data.x(:,1)) min(data.x(:,2)) max(data.x(:,2))];
end

%% Gerando os dados para superfície de decisão
inc = 0.02; %0.02
[x, y] = meshgrid(range(1):inc:range(2), range(3):inc:range(4));
xy = [x(:) y(:)];
testeXY.x = xy;

if (strcmp(conf.algoritmo, 'DMC') == 1)
    % Treinando o DMC
    [centroides] = trainDMC(data);
    
    % Rotulando a superfícei de decisão
    [classeXY] = testeDMC(centroides, testeXY);
elseif (strcmp(conf.algoritmo, 'KNN') == 1)
    
    % Rotulando a superfícei de decisão
    [classeXY] = testeKNN(data, testeXY, conf.K);
    
elseif (strcmp(conf.algoritmo, 'janelaParzen') == 1)
    
    [modelo] = trainPzWin(data);
    [classeXY, valorXY] = testePzWin(modelo, testeXY, conf.h);
    
elseif (strcmp(conf.algoritmo, 'mixGaus') == 1)
    
    [modelo] = trainGausMix(data, conf);
    [classeXY, valorXY] = testeGausMix(modelo, testeXY);
    
else
    %% Treinamento do Bayes
    [modelo] = trainBayes(data);
    
    %% Testando o DMC
    [classeXY, valorXY] = testeBayes(modelo, testeXY, conf);
end

numClass = length(unique(classeXY));
if (sum(find(0==classeXY)) ~= 0)
%     classeXY = classeXY + 1;
    classeXY = classeXY + 1;
    aux = unique(classeXY);
    numClass = aux(length(aux));
end

% sum(classeXY == 1)
% sum(classeXY == 2)
% if (length(unique(classeXY)) == 3) 
%     sum(classeXY == 3)
% end

cores = hsv(numClass);
surf(x, y,  reshape(valorXY, [length(x) length(y)] ), ...
    reshape(cores(classeXY, :), [length(x) length(y) 3]));

% surf(x, y,  reshape(valorXY, [length(x) length(y)] ), ...
%     reshape(cores(classeXY, :), [length(x) length(y) 3]), 'EdgeColor','none');

end

