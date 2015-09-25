function [ erro, W ] = trainNeuralGas( dados, conf )

[N, ~] = size(dados.x);

%% Criando a rede
% Vetor de pesos
% ind = randperm(N);
% W = zeros( prod(conf.tamanho), size(dados.x,2));
W = repmat( mean(dados.x), conf.numNeur, 1);


%% Treinando a rede
v_i = 1;
v_f = 0.001;
alfa_i = 0.01;
alfa_f = 0.001;
for epoca = 1 : conf.epocas,
    
    erro = [];
    h = [];
    for i = 1 : N,
        
        x = dados.x(i,:);
        [~, posicoes] = sort(pdist2(x, W));
        erro = [erro; x - W(posicoes(1),:)]; % erro para quantizacao
        
        %% Atualizacao do vetor de pesos
        v = v_i*nthroot( (v_i/v_f)^i, conf.epocas*N);
        alfa = alfa_i*nthroot( (alfa_i/alfa_f)^i, conf.epocas*N);
        
        h = exp(- (posicoes - 1)/v^2)';
        erros = repmat(x, size(W,1), 1) - W;
        
        W = W + alfa*repmat(h, 1, size(erros,2)).*erros;
        
        %         %% Neuronios vencendor (eucl e prod escal) e amostra
        %         close all
        %         plot(dados.x(:,1), dados.x(:,2), 'xg')
        %         hold on
        %         plot(W(:,1), W(:,2), 'or')
        %         plot(x(1), x(2), 'db')
        %         keyboard
    end
    
    quant(epoca) = sum(sum(erro.^2))/N;
    
    
    %     if (quant(epoca) <= 0.007)
    %         quant
    %         break;
    %     end
    
    
    %     %% Neuronios em uma epoca
    %     close all
    %     plot(dados.x(:,1), dados.x(:,2), 'xg')
    %     hold on
    %     plot(W(:,1), W(:,2), 'or')
    %     keyboard
    
    
    
    
    %% Embaralhando os dados
    ind = randperm(N);
    dados.x = dados.x(ind, :);
    
    epoca = epoca + 1;
end


%% Epocas x Erro Quant
figure
plot([1:1:length(quant)], quant)
keyboard


erro = sum(quant)/conf.epocas;

end

