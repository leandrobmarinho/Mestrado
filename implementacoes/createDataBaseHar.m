clear all; close all; clc

dados.x = load('dados/HAR/train/X_train.txt');
dados.x = [dados.x; load('dados/HAR/test/X_test.txt')];

dados.y = load('dados/HAR/train/y_train.txt');
dados.y = [dados.y; load('dados/HAR/test/y_test.txt')];

% lin = size(dados.x,1);
% minimo = min(dados.x);
% maximo = max(dados.x);
% media = mean(dados.x);
% minRep = repmat(minimo, lin, 1);
% maxRep = repmat(maximo, lin, 1);
% mediaRep = repmat(media, lin, 1);
% dados.x = (dados.x - mediaRep)./(maxRep - minRep);

dados2 = dados;
tipo = 1

for i = 1 : 6
    dados2.y(dados.y == i) = i-1;
end

if tipo == 0
    %% Base completa

    ans = [dados2.x dados2.y];
    csvwrite('har.txt', ans)
elseif tipo ==1 
    %% PCA 
    
    [V E] = eig( cov(dados2.x) );
    [E order] = sort(diag(E), 'descend');
    V = V(:,order);
    
    sumE = cumsum(E)/sum(E);
    [~, ultimo] = max(sumE >= 0.98);
    V = V(:, 1:ultimo);
    
    dados2.x = dados2.x*V;
    
    ans = [dados2.x dados2.y];
    csvwrite('harPCA.txt', ans)
end

%% Base com PCA

