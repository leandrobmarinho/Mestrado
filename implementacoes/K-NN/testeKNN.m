function [Yh] = testeKNN(dadosTrein, dadosTeste, k)

%  keyboard

lin = size(dadosTeste.x, 1);
numClass = length(dadosTrein.y(1, :));

%% Calculando distancia entre os dados de treinamento e os de teste
dist = pdist2(dadosTrein.x, dadosTeste.x);
[~, posicoes] = sort(dist);


Yh = [];
for i = 1: lin,
    
    % Separando os k-vizinhos
    vizinhos.x = dadosTrein.x(posicoes(1:k, i), :);
    vizinhos.y = dadosTrein.y(posicoes(1:k, i), :);
    
    
    if (size(dadosTrein.y, 2) > 2)
        
        % Multi-classes
        [~, indsVizinhos] = max(vizinhos.y');
        classeVizinhos = mode(indsVizinhos);
        
        chosen = zeros(1, numClass);
        chosen(classeVizinhos) = 1;
        Yh = [Yh; chosen];
    else
        
        % Classificação binária
        classeVizinhos = mode(vizinhos.y');
        Yh = [Yh; classeVizinhos];
    end
        
end