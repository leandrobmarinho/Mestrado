function [ modelo ] = trainSOM_KNN( dados, config )

[~, W] = trainSOM(dados, config);

dist = pdist2(dados.x, W);
[~, posicoes] = sort(dist);

for i = 1 : size(W,1)
    
    y = dados.y(posicoes(1:config.K, i), :);
    
    U = unique(y);
    H = histc(y,U);
    
    if (length(U(H==max(H))) == 1)
        Wy(i) = U(H==max(H));
    else
        Wy(i) = 0;
    end
    
end

modelo.Wy = Wy';
modelo.W = W;

% pos = gridtop(config.tamanho)
% labels = cellstr( num2str([modelo.Wy']') );
% plotsom(pos)
% if (size(pos,1) == 1)
%     pos = [pos; zeros(1,size(pos,2))];
% end
% pos_ = pos';
% text(pos_(:,1), pos_(:,2), labels, 'VerticalAlignment','bottom', ...
% 'HorizontalAlignment','right')

end