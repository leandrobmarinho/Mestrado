function [ output ] = testeSOM(modelo, dados)

[N, ~] = size(dados.x);


erro = [];
for i = 1 : N,
    x = dados.x(i,:);
    
    % Busca pelo neuronio vencendor
    [~, win] = min(pdist2(x, modelo.W));
    
    erro = [erro; x - modelo.W(win,:) ]; % erro para quantizacao
    
end


output = sum(sum(erro.^2))/N;


end

