function [modelo] = treinoRBF(dados, conf)

% dados.x
% dados.y
d = size(dados.x, 2);
l = size(dados.x, 1);

% Inicializando a matriz entre camada de entrada e oculta
ID = randperm(l);

if conf.nOcultos > l
    conf.nOcultos = l;
end
    
W = dados.x(ID(1:conf.nOcultos), :);


Z = pdist2(dados.x, W);
Z = exp(-conf.gamma*(Z.^2));

Z = [ones(size(Z, 1), 1) Z];

m = Z\dados.y;

modelo.W = W;
modelo.m = m;
modelo.nOcultos = conf.nOcultos;
modelo.gamma = conf.gamma;

end