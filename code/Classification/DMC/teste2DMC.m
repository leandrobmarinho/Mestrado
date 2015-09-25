function [classesCentr] = teste2DMC(centroides, dadosTeste, nTrain)


lin = size(dadosTeste.x, 1);

%% Calcula distancia entre os dados de treinamento e os de teste
dist = pdist2(centroides.x, dadosTeste.x);
[~, posicoes] = sort(dist);

classesCentr = [];
for i = 1: lin,
    
    if (size(dadosTeste.y, 2) > 2)
        
        % Multi-classes
        classesCentr = [classesCentr; centroides.y(posicoes(1,i), :)];
        
        % Atualiza o centroide se houver acerto
        if (sum(abs(centroides.y(posicoes(1,i), :) - dadosTeste.y(i,:))) == 0)
            alfa = 1 / (nTrain + 1);
            centroides.x(posicoes(1,i), :) = (1-alfa)*centroides.x(posicoes(1,i), :) + alfa*dadosTeste.x(i,:);
            nTrain = nTrain + 1;
        end
    end
    
end

classesCentr = centroides.y(posicoes(1,:), :);

end