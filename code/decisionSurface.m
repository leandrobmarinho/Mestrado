function [ ] = decisionSurface( range, conf, data, atr)
%DECISIONSURFACE Summary of this function goes here
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

inc = 0.008;
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
    
elseif (strcmp(conf.algoritmo, 'janelaParzen') == 1)
    
    [modelo] = trainPzWin(data);
    [classeXY] = testePzWin(modelo, testeXY, conf.h);
    
elseif (strcmp(conf.algoritmo, 'mixGaus') == 1)
    
    [modelo] = trainGausMix(data, conf);
    [classeXY] = testeGausMix(modelo, testeXY);

elseif (strcmp(conf.algoritmo, 'SVM') == 1)
    
    if (strcmp('rbf', conf.fkernel) == 1)
        
        modelo = svmtrain(data.x, data.y,'kernel_function',...
            conf.fkernel,'rbf_sigma', conf.sigma,'boxconstraint',conf.paraC,...
            'method',conf.metodo,'kernelcachelimit',15000);
    else
        modelo = svmtrain(data.x, data.y,'kernel_function',...
            conf.fkernel,'boxconstraint',conf.paraC,...
            'method',conf.metodo,'kernelcachelimit',15000);
    end
    [classeXY] = svmclassify(modelo, testeXY.x);

    
else
    
    %% Treinamento do Bayes
    [modelo] = trainBayes(data);
    
    %% Testando
    [classeXY] = testeBayes(modelo, testeXY, conf);
end

if (size(classeXY, 1) > 1)
    [~, idx] = max(classeXY');
    idx = idx';
else
    idx = classeXY';
end
numClass = length(unique(classeXY));

% decisionmap = reshape(idx, image_size);




% Só para o caso da classificação com rejeição
rej = false;
if (sum(find(0==classeXY)) ~= 0)
    rej = true;
    
    classeXY = classeXY + 1;
    aux = unique(classeXY);
    numClass = aux(length(aux));
    
end

unique(classeXY)
% fprintf('%d\n', sum(classeXY == 1) )
% fprintf('%d\n', sum(classeXY == 2) )
% if (length(unique(classeXY)) == 3) 
%     fprintf('%d\n', sum(classeXY == 3) )
% end


cmap = [1 0.8 0.8; 0.8 1 0.8; 0.7 0.7 1];
% cmap = lines(3);%spring
cmap = [1 0 0; 0 0.5 0; 0 0 1];
% cmap = rgb2hsv(cmap);

% n = brighten(cmap, .5);
% colormap(n);


plotar = [];
hold all

% for i = numClass : -1 : 1,
for i = 1 : numClass,
    
    %Seleciona apenas as amostras com a classe pretendida
    indxSD = find(classeXY == i);
    if not(isempty(indxSD))
        if (~rej)
            plotBG(i) = plot(xy(indxSD,1), xy(indxSD,2), '*', 'Color', cmap(i+1,:));
        else
            plotBG(i) = plot(xy(indxSD,1), xy(indxSD,2), '*', 'Color', cmap(i,:));
        end
    end
    
end

% cmap = prism(numClass*numClass);
% cmap = [0 0 1; 0 1 0];
cmap = [0 0 0.1; 1 0 0]; 
% colormap(cmap);

for i = 1 : numClass,
        
    indTrain = find(data.y == i);
    if not(isempty(indTrain))
        plotar(i) = plot(data.x(indTrain,1), data.x(indTrain,2), 'o', 'Color', cmap(i,:)); %cmap(i*(numClass-1),:)
    end 
end

hold off
% legend(plotar, 'Setosa ', 'Versicolor ', 'Virgínica', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal');
% legend(plotar, 'Hernia', 'Spondylolisthesis', 'Normal', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal');
legend(plotar, '-1', '+1', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal');

% if rej
%     if (numClass == 3)
%         legend(plotBG, 'Rej', 'Classe 1', 'Classe 2', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal');
%     else
%         legend(plotBG, 'Rej', 'Classe 1', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal');
%     end
% end

end