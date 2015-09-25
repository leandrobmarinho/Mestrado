close all; clear all; clc; addpath('..');

load('resultadoSOMNN');

%% Plotando a taxa de acerto
cores = lines(size(txAcert,3));

txAcertoMedia = mean(txAcert);
for i = 1 : size(txAcert,3)
    
    plot([5 10 15 20 25 30 50], txAcertoMedia(:,:,i), '-o', 'Color', cores(i,:));
    hold on
end
legend(arrayfun(@(x) sprintf('%d',x),Ks,'uni', false).', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal')
xlabel('Tamanho', 'FontSize', 14);
ylabel('Acurácia', 'FontSize', 14);

%% Plotando os neuronios com as classes
%Configurações gerais
tam = 4; %4 [5 10 15 20 25 30 50]
k = 2; % [1 3 5 7]

[v, pos] = max(txAcert);
modelo = modeloNN{pos(1,tam,2), tam, 2};
confusionMatrices{pos(1,tam,2), tam, 2}

figure
plotsom(modelo.pos);
hold on

if (size(modelo.pos,1) == 1)
    modelo.pos = [modelo.pos; zeros(1,size(modelo.pos,2))];
end

classes = unique(modelo.Wy);
cores = jet(6);
indices = [6 4 5 1 3 2];

for i = 1 : 6
    ind = find(modelo.Wy == indices(i));
    plotar(i) = plot(modelo.pos(1,ind), modelo.pos(2,ind), '*', 'linewidth', 6, 'Color', cores(i,:));
    hold on
end

if (length(classes) == 6)
    legend(plotar, 'Deitado', 'Sentado', 'Em Pe', 'Andando', 'Desc Esc', 'Subind Esc', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal')
elseif (length(classes) == 7)
    ind = find(modelo.Wy == 0 );
    plotar(7) = plot(modelo.pos(1,ind), modelo.pos(2,ind), '*', 'linewidth', 6, 'Color', [1, 0.4, 0.6]);
    hold on
    legend(plotar, 'Deitado', 'Sentado', 'Em Pe', 'Andando', 'Desc Esc', 'Subind Esc', '0', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal')
end