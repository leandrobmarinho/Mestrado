function [ ] = decisionSurface( range, conf, data, atr)
%DECISIONSURFACE Summary of this function goes here
% range - intervalo do grafico, se vazio será calculado
% conf.algoritmo
%   DMC
%   KNN
%   bayes
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

inc = 0.02;
% gera a grade de coordenadas
[x, y] = meshgrid(range(1):inc:range(2), range(3):inc:range(4));
 
xy = [x(:) y(:)];

image_size = size(x);

testeXY.x = xy;

if (strcmp(conf.algoritmo, 'DMC') == 1)
    % Treinando o DMC
    [centroides] = trainDMC(data);
    
    % Rotulando a superfícei de decisão
    [classeXY] = testeDMC(centroides, testeXY);
elseif (strcmp(conf.algoritmo, 'KNN') == 1)
    
    % Rotulando a superfícei de decisão
    [classeXY] = testeKNN(data, testeXY, conf.K);

else
    
    %% Treinamento do Bayes
    [modelo] = trainBayes(data);
    
    %% Testando o DMC
    [classeXY] = testeBayes(modelo, testeXY, conf);
end

if (size(classeXY, 1) > 1)
    [~, idx] = max(classeXY');
    idx = idx';
else
    idx = classeXY';
end

decisionmap = reshape(idx, image_size);


% figure,

numClass = length(unique(classeXY));
cmap2 = hsv(numClass);
cmap = [1 0.8 0.8; 0.8 1 0.8; 0.7 0.7 1];
colormap(cmap);


plotar = [];
hold all
% for i = numClass : -1 : 1,
for i = 1 : numClass,
    
    %Seleciona apenas as amostras com a classe pretendida
    indxSD = find(classeXY == i);
    if not(isempty(indxSD))
        plot(xy(indxSD,1), xy(indxSD,2), '*', 'Color', cmap(i,:))
    end
    
end

for i = 1 : numClass,
        
    indTrain = find(data.y == i);
    if not(isempty(indTrain))
        plotar(i) = plot(data.x(indTrain,1), data.x(indTrain,2), 'o', 'Color', cmap2(i,:));
    end 
end

hold off
legend(plotar, 'Setosa ', 'Versicolor ', 'Virgínica', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal');


end