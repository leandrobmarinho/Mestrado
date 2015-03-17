function [ output ] = trainWTA( dados, conf )

[N, ~] = size(dados.x);

%% Criando a rede
% Vetor de pesos
ind = randperm(N);
W = dados.x(ind(1:prod(conf.tamanho)), :);
% W = zeros( prod(conf.tamanho), size(dados.x,2));



%% Treinando a rede
for epoca = 1 : conf.epocas,
    
    erro = [];
    for i = 1 : N,
        x = dados.x(i,:);
        
        % Busca pelo neuronio vencendor
        [~, win] = min(pdist2(x, W));
        [~, win2] = max(x*W');
        
        
        % Atualizacao do vetor de pesos
        % MUDAR A TAXA DE APRENDIZAGEM
        erro = [erro; x - W(win,:) ];
        W(win,:) = W(win,:) + 0.1*(erro(i, :));
        
        
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

% plot([1:1:length(quant)], quant)

keyboard

output = [];

end

