function [ output ] = testeSOM_KNN(modelo, dados)

dist = pdist2(modelo.W, dados.x);
[~, posicoes] = sort(dist);
output = modelo.Wy(posicoes(1,:));

% [N, ~] = size(dados.x);

% erro = [];
% for i = 1 : N,
%     x = dados.x(i,:);
%     
%     % Busca pelo neuronio vencendor
%     [~, win] = min(pdist2(x, W));
%     
%     erro = [erro; x - W(win,:) ]; % erro para quantizacao
%     
% end
% 
% output = sum(sum(erro.^2))/N;


end

