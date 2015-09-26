function [ dados ] = normalizeData( dados, opcao )
%NORMALIZADADOS Summary of this function goes here
% [1] - (dados - media)./(max - min)

[lin, ~] = size(dados);

if (opcao == 1)
    minimo = min(dados);
    maximo = max(dados);
    media = mean(dados);
    minRep = repmat(minimo, lin, 1);
    maxRep = repmat(maximo, lin, 1);
    mediaRep = repmat(media, lin, 1);
    dados = (dados - mediaRep)./(maxRep - minRep);
end

end

