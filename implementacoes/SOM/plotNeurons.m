function [ output_args ] = plotNeurons( dados, W, pos, D, conf)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

labels = cellstr( num2str([1:prod(conf.tamanho)]') );
%% vizinhanca dos pesos
figure
plotsom(pos)
if (size(pos,1) == 1)
    pos = [pos; zeros(1,size(pos,2))];
end
pos_ = pos';
text(pos_(:,1), pos_(:,2), labels, 'VerticalAlignment','bottom', ...
'HorizontalAlignment','right')

%% Dados e neuronios
figure
plot(dados.x(:,1), dados.x(:,2), 'xb')
hold on
plot(W(:,1), W(:,2), 'or')
text(W(:,1), W(:,2), labels, 'VerticalAlignment','bottom', ...
'HorizontalAlignment','right')

for (neu = 1 : prod(conf.tamanho))
    inds = find(D(neu,:) <= conf.vizinhos);
    
    for (i = 1 : length(inds))
        
        hold on
        plot(W([neu inds(i)], 1), W([neu inds(i)], 2), '-', 'Color',[0,0.7,0.9])
    end
end


end

