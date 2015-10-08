function [modelo] = treinoPerceptron(dados, conf)

% dados.x
% dados.y
if (not(isfield(conf, 'epocas')))
    conf.epocas = 200;
end

if (not(isfield(conf, 'alfa')))
    conf.alfa = 0.01;
end

d = size(dados.x, 2);
lin = length(dados.x);

X_train = [ones(length(dados.x), 1) dados.x]; 
W = rand(size(dados.y, 2), d+1); %pesos

erro = true;
epoca = 0;
while (erro == true) && (epoca < conf.epocas)
    erro = false;
    
    for ii = 1 : lin,
        X = X_train(ii, :);
        
        saida = X*W';
        [~, indEncontrado] = max(saida);
        [~, indEstimado] = max(dados.y(ii, :));
        
        if ( indEncontrado ~=  indEstimado)
            % Atualiza os pesos
            W = W + conf.alfa * (dados.y(ii, :) - saida)' * X;
            erro = true;
        end
    end
    epoca = epoca + 1;
    
    ind = randperm(lin);
    X_train = X_train(ind,:);
end

modelo.W = W;
modelo.epocas = conf.epocas;
modelo.alfa = conf.alfa;

end