function [modelo] = treinoRBF(dados, conf)

% dados.x
% dados.y
d = size(dados.x, 2);
l = size(dados.x, 1);

% Inicializando a matriz entre camada de entrada e oculta
% ID = randperm(l);
% if conf.nOcultos > l
%     conf.nOcultos = l;
% end
% W = dados.x(ID(1:conf.nOcultos), :);

if ( isfield(conf, 'W') == 0 )
    fprintf('Posicionando neurônios.\n')

    [modeloSOM, ~] = trainSOM(dados, conf);
    conf.W = modeloSOM.W;
    
%     net = selforgmap(conf.tamanho);
%     [net, tr] = train(net, dados.x');
%     conf.W = net.IW{1};
end

Z = pdist2(dados.x, conf.W);
Z = exp(-conf.gamma*(Z.^2));

Z = [ones(size(Z, 1), 1) Z];

modelo.m = Z\dados.y;
modelo.W = conf.W;
modelo.gamma = conf.gamma;

% modelo.nOcultos = conf.nOcultos;

end