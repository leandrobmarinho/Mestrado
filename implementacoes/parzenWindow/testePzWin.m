function [ output ] = testePzWin( modelo, dados, h)
%TESTEPZWIN Summary of this function goes here
%   Detailed explanation goes here

prob = [];
for j = 1 : length(modelo.aprioriClass)
    
    prob = [prob; modelo.aprioriClass(j)*...
        parzenWindow( dados.x, modelo.dadosTrain{j}.x, h)];
end
[~, output] = max(prob);

end

