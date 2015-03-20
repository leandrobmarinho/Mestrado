function [ ] = decisionSurface( range, algoritmo, data, K, atr)

%% Seleciona os atributos
data.x = data.x(:,atr);

 
%% Gerando os dados para superfície de decisão

inc = 0.06;
% gera a grade de coordenadas
[x, y] = meshgrid(range(1):inc:range(2), range(3):inc:range(4));
 
xy = [x(:) y(:)];

image_size = size(x);

testeXY.x = xy;


if (strcmp(algoritmo, 'DMC') == 1)
    % Treinando o DMC
    [centroides] = trainDMC(data);
    
    % Rotulando a superfícei de decisão
    [classeXY] = testeDMC(centroides, testeXY);
elseif (strcmp(algoritmo, 'KNN') == 1)
    
    % Rotulando a superfícei de decisão
    [classeXY] = testeKNN(data, testeXY, K);

elseif ( strcmp(algoritmo, 'bayes') == 1 )
    %% Treinamento do Bayes
    [modelo] = trainBayes(data);
    
    custo = [0 1 1; 1 0 1; 1 1 0];
    %% Testando o DMC
    [classeXY] = testeBayes(modelo, testeXY, custo);
end

[~, idx] = max(classeXY');
idx = idx';
decisionmap = reshape(idx, image_size);


% figure,
numClass = length(data.y(1, :));
cmap2 = hsv(numClass);
cmap = [1 0.8 0.8; 0.8 1 0.8; 0.7 0.7 1];
colormap(cmap);


plotar = [];
hold all
for i = 1 : numClass,
    cent = zeros(1, numClass);
    cent(i) = 1;
    
    %Seleciona apenas as amostras com a classe pretendida
    indxSD = find(cent * classeXY');
    if not(isempty(indxSD))
        plot(xy(indxSD,1), xy(indxSD,2), '*', 'Color', cmap(i,:))
    end
    
    indTrain = find(cent * data.y');
    if not(isempty(indTrain))
        plotar(i) = plot(data.x(indTrain,1), data.x(indTrain,2), 'o', 'Color', cmap2(i,:));
    end 
end
hold off
legend(plotar, 'Setosa ', 'Versicolor ', 'Virgínica', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal');


end