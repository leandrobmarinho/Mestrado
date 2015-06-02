function [modelo, erro] = trainSOM( dados, conf )
% TRAINSOM
%   dados - Dados para treinamento.
%   conf.vizinhos - Tamanho da vizinhaça. Padrão 1
%   conf.topopologia - Tipo da topologia. Padrão 'g'
%        'g' - grade 
%        'h' - hexagonal
%   conf.dist - Tipo de distância da vizinhança. Padrão 'b'
%        'b' - boxdist
%        'l' - linkdist
%   conf.tamanho - Quantidade de neurônios [lin col].
%   conf.epocas - Número de épocas. Padrão 100.
%   conf.v_i - valor inicial do cálculo da vizinhança
%   conf.v_f - valor final do cálculo da vizinhança
%   conf.alfa_i - valor inicial do cálculo da taxa de aprendizagem
%   conf.alfa_i - valor final do cálculo da taxa de aprendizagem


%% Validações
if (isfield(conf, 'vizinhos') == 0)
    conf.vizinhos = 1;
end
if (isfield(conf, 'topologia') == 0)
    conf.topologia = 'g';
end
if (isfield(conf, 'dist') == 0)
    conf.dist = 'b';
end
if (isfield(conf, 'epocas') == 0)
    conf.epocas = 200;
end



%% Criando a rede
[N, ~] = size(dados.x);

% Vetor de pesos
% W = zeros( prod(conf.tamanho), size(dados.x,2));
W = repmat( mean(dados.x), prod(conf.tamanho), 1);
count = zeros(1, prod(conf.tamanho));


% Topologia dos neuronios
if (strcmp(conf.topologia, 'g') == 1)
    pos = gridtop(conf.tamanho);
elseif (strcmp(conf.topologia, 'h') == 1)
    pos = hextop(conf.tamanho);
end

if (strcmp(conf.dist, 'b') == 1)
    D = boxdist(pos);
elseif (strcmp(conf.dist, 'l') == 1)
    D = linkdist(pos);
end

% %% Plotando a topologia
% labels = cellstr( num2str([1:prod(conf.tamanho)]') );
% plotsom(pos)
% if (size(pos,1) == 1)
%     pos = [pos; zeros(1,size(pos,2))];
% end
% pos_ = pos';
% text(pos_(:,1), pos_(:,2), labels, 'VerticalAlignment','bottom', ...
% 'HorizontalAlignment','right')
% find (D(5, :) == 1)
% keyboard


%% Treinando a rede
for epoca = 1 : conf.epocas,

    count = zeros(1, prod(conf.tamanho));
    erro = [];
    h = [];
    for i = 1 : N,
        x = dados.x(i,:);
        
        % Busca pelo neuronio vencendor
        f = (count/i).^2;
         
        [~, win] = min(f.*pdist2(x, W));
        % [~, win2] = max(x*W');
        count(win) = count(win) + 1;
        
        erro = [erro; x - W(win,:) ]; % erro para quantizacao        
        
        %% Atualizacao do vetor de pesos        
        indViz = find(D(win,:) <= conf.vizinhos);
        
        v = conf.v_i*nthroot( (conf.v_f/conf.v_i)^i, conf.epocas*N);
        alfa = conf.alfa_i*nthroot( (conf.alfa_f/conf.alfa_i)^i, conf.epocas*N);
%         alfa = conf.alfa_i*i + conf.alfa_f;

        
        h = exp(- ((D(win, indViz)).^2)/v^2)';
        erros = repmat(x, length(indViz),1) - W(indViz, :);
        
        if (isnan(W(indViz, :) + alfa*repmat(h,1,size(erros,2)).*erros))
            keyboard
        end
        
        W(indViz, :) = W(indViz, :) + alfa*repmat(h,1,size(erros,2)).*erros;
        
        if (isnan(W) == 1)
            keyboard
        end
        
%         %% Neuronios vencendor (eucl e prod escal) e amostra
%         close all
%         plot(dados.x(:,1), dados.x(:,2), 'xg')
%         hold on
%         plot(W(:,1), W(:,2), 'or')
%         plot(x(1), x(2), 'db')
%         plot(W(win,1), W(win,2), '+m')
%         plot(W(win2,1), W(win2,2), '+k')
%         keyboard
        

    end
    
    quant(epoca) = sum(sum(erro.^2))/N;
        
    if (epoca > 40)        
        frame = quant(end-30:end);

        if (mean(abs(diff(frame))) <= 6 && mean(frame) <= 9)
            fprintf('Estabilizou na epoca %d\n', epoca);
            break;
        end
    end

%     %% Neuronios em uma epoca
%     close all
%     plot(dados.x(:,1), dados.x(:,2), 'xg')
%     hold on
%     plot(W(:,1), W(:,2), 'or')
%     keyboard
    
    
    %% Embaralhando os dados
    ind = randperm(N);
    dados.x = dados.x(ind, :);
    
    fprintf('Treinando a SOM. Faltam %d épocas.\n', conf.epocas - epoca)
    
    epoca = epoca + 1;
    
end


% %% Epocas x Erro Quant
% figure
% plot([1:1:length(quant)], quant)
% 
% somAlerta()
% keyboard


%% Plota os neuronios
% figure
% subplot(1, 2, 1)
% plotNeurons(dados, W, pos, D, conf)
% 
% subplot(1, 2, 2)
% net = selforgmap(conf.tamanho)
% [net,tr] = train(net,dados.x');
% plotNeurons(dados, net.IW{1}, pos, D, conf)
% 
% keyboard

% erro = sum(quant)/conf.epocas;
erro = quant;
modelo.W = W;
modelo.pos = pos;

end

