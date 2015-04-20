function [ modelo ] = trainVC(dados, params, nTreinos, ptrn)
%TRAINVC Summary of this function goes here
%   Detailed explanation goes here

fprintf('Treinando a SOM_K-NN. Buscando o melhor modelo...')

errosTrein = [];
erros = zeros(nTreinos, 1);
for i = 1 : nTreinos
    [learnPoints, testData] = embaralhaDados(dados, ptrn, 2);
    save('resultadoSOM-KNN_VC');
    
    fprintf('Buscando o melhor modelo... Passo %d\n',i);
    
    tic
    
    [ modelo{i}, errTrn ] = trainSOM_KNN(learnPoints, params);
    errosTrein = [errosTrein; errTrn];
    
    [Yh] = testeSOM_KNN(modelo{i}, testData);
    
    % Calculando erro
    erros(i) = 1 - (trace(confusionmat(testData.y, Yh)) / length(testData.y));
    save('resultadoSOM-KNN_VC');
    
    toc
end

[~, indice] = min(erros);
modelo = modelo{indice};
save('resultadoSOM-KNN_VC');

%% Plotando os erros de treinamento
figure
for i = 1 : nTreinos
    plot([1:1:size(errosTrein, 2)], errosTrein(i,:), '-b')
    hold on
end
mediaErro = mean(errosTrein, 1);
plot([1:1:length(mediaErro)], mediaErro, '-r')


%% Plotando os neuronios com as classes
figure
classes = unique(modelo.Wy);

plotsom(modelo.pos);
hold on

if (size(modelo.pos,1) == 1)
    modelo.pos = [modelo.pos; zeros(1,size(modelo.pos,2))];
end

for i = 1 : length(classes)
    labels{i} = cellstr( num2str( classes(i)*ones(length(find(modelo.Wy == classes(i))), 1) ) );
    
    ind = find(modelo.Wy == classes(i))
    text(modelo.pos(1, ind), modelo.pos(2, ind), labels{i}, 'VerticalAlignment','bottom', ...
        'HorizontalAlignment','right')
    hold on
end

end

