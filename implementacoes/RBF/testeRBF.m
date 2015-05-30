function [output] = testeRBF(modelo, dados)

Y = dados.y;

Z = pdist2(dados.x, modelo.W);

Z = exp(-modelo.gamma*(Z.^2));

Z = [ones(size(Z, 1), 1) Z];

Yh = Z*modelo.m;


if (size(Y,2) > 2)
    %Multi-Classes
    
    [~, output] = max(Yh');
else
    
    %2 Classes
    output = sign(Yh);
end

end