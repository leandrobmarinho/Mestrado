function [ erro, W ] = trainSOM( dados, conf )

[N, ~] = size(dados.x);

%% Criando a rede
% Vetor de pesos
ind = randperm(N);
W = dados.x(ind(1:prod(conf.tamanho)), :);
% W = zeros( prod(conf.tamanho), size(dados.x,2));

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
% plotsom(pos)


v_i = 1;
v_f = 0.001;
%% Treinando a rede
for epoca = 1 : conf.epocas,
    
    erro = [];
    h = [];
    for i = 1 : N,
        x = dados.x(i,:);
        
        % Busca pelo neuronio vencendor
        [~, win] = min(pdist2(x, W));
        [~, win2] = max(x*W');
        
        erro = [erro; x - W(win,:) ]; % erro para quantizacao        
        
        % Atualizacao do vetor de pesos
        % MUDAR A TAXA DE APRENDIZAGEM
        indViz = find(D(win,:) <= conf.vizinhos);
        
        
        v = v_i*nthroot( (v_i/v_f)^i, conf.epocas*N);
        h = exp(- ((D(win, indViz)).^2)/v)';
        erros = repmat(x, length(indViz),1) - W(indViz, :);
        W(indViz, :) = W(indViz, :) + 0.01*repmat(h,1,size(erros,2)).*erros;
        
        
%         close all
%         plot(dados.x(:,1), dados.x(:,2), 'xg')
%         hold on
%         plot(W(:,1), W(:,2), 'or')
%         plot(x(1), x(2), 'ob')
%         plot(W(win,1), W(win,2), '+m')
%         plot(W(win2,1), W(win2,2), '+k')
        

    end
    
    quant(epoca) = sum(sum(erro.^2))/N;
    
    
%     if (quant(epoca) <= 0.007)
%         quant
%         break;
%     end


%     close all
%     plot(dados.x(:,1), dados.x(:,2), 'xg')
%     hold on
%     plot(W(:,1), W(:,2), 'or')
    
    
    
    
    %% Embaralhando os dados
    ind = randperm(N);
    dados.x = dados.x(ind, :);
    
    epoca = epoca + 1;
end

% Epocas x Erro Quant
% plot([1:1:length(quant)], quant) 

% Dados e neuronios
% figure
% plot(dados.x(:,1), dados.x(:,2), 'xg')
% hold on
% labels = cellstr( num2str([1:prod(conf.tamanho)]') );
% plot(W(:,1), W(:,2), 'or')
% text(W(:,1), W(:,2), labels, 'VerticalAlignment','bottom', ...
% 'HorizontalAlignment','right')

% vizinhanca dos pesos
% figure
% plotsom(pos)
% pos_ = pos';
% text(pos_(:,1), pos_(:,2), labels, 'VerticalAlignment','bottom', ...
% 'HorizontalAlignment','right')


erro = sum(quant)/conf.epocas;

end

