function [ modelo ] = trainVC(dados, params, nTreinos, ptrn)
%TRAINVC Summary of this function goes here
%   Detailed explanation goes here

fprintf('Treinando a SOM_K-NN. Buscando o melhor modelo...')

errTreinEpoc = [];
acertosTrein = zeros(nTreinos, 1);
for i = 1 : nTreinos
    [learnPoints, testData] = embaralhaDados(dados, ptrn, 2);
%     save('resultadoSOM-KNN_VC','-append');
    
    fprintf('Buscando o melhor modelo... Passo %d\n',i);
    
    tic
    
    [ modelo{i}, errTrn ] = trainSOM_KNN(learnPoints, params);
    errTreinEpoc = [errTreinEpoc; errTrn];
    
    [Yh] = testeSOM_KNN(modelo{i}, testData);
    
    % Calculando erro
    acertosTrein(i) = trace(confusionmat(testData.y, Yh)) / length(testData.y);
    
    toc
    
%     save('resultadoSOM-KNN_VC','-append');
end
keyboard

[~, indice] = max(acertosTrein);
modelo = modelo{indice};
% save('resultadoSOM-KNN_VC','-append');

%% Plotando os erros de treinamento
figure
for i = 1 : nTreinos
    plot(1:1:size(errTreinEpoc, 2), errTreinEpoc(i,:), '-b')
    hold on
end
mediaErro = mean(errTreinEpoc, 1);
plot(1:1:length(mediaErro), mediaErro, '-r')


%% Plotando os neuronios com as classes
figure
classes = unique(modelo.Wy);

plotsom(modelo.pos);
hold on

if (size(modelo.pos,1) == 1)
    modelo.pos = [modelo.pos; zeros(1,size(modelo.pos,2))];
end

cores = colorcube(length(classes));
cores = cores([7 6 4 5 1 3 2],:);

indices = [7 6 4 5 1 3 2];
for i = 1 : length(classes)
    
    ind = find(modelo.Wy == classes(i) );
    plotar(indices(i)) = plot(modelo.pos(1,ind), modelo.pos(2,ind), '*', 'linewidth', 6, 'Color', cores(i,:));
    hold on
end

legend(plotar, 'Deitado', 'Sentado', 'Em Pe', 'Andando', 'Desc Esc', 'Subind Esc', '0', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal')

% labels = cellstr( num2str(modelo.Wy) );
% pos_ = modelo.pos';
% text(pos_(:,1), pos_(:,2), labels, 'VerticalAlignment','bottom', ...
% 'HorizontalAlignment','right', 'FontSize', 14)

end

