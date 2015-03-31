function [centroides] = trainDMC(dadosTrein)

% keyboard

centroidesX = [];
centroidesY = [];
for i = 1 : length(dadosTrein.y(1, :)),
    cent = zeros(1, length(dadosTrein.y(i, :)));
    cent(i) = 1;
    
    % Seleciona apenas as amostras com a classe pretendida
    indx = find(cent * dadosTrein.y');
    if not(isempty(indx))
        centroidesX = [centroidesX; mean(dadosTrein.x(indx, :))];
        centroidesY = [centroidesY; dadosTrein.y(indx(1), :)];
    end
end

centroides.x = centroidesX;
centroides.y = centroidesY;

end