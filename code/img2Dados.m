function [ dados ] = img2Dados( imgs, isTest, varargin )
%IMG2DADOS Summary of this function goes here
%   Detailed explanation goes here
%   imagem - cell
%   tipo 'teste' - sem saida e repetidos

% keyboard
dados.x = [];
dados.y = [];
for i = 1 : size(imgs,2)
    
    [linhas colunas dim] = size(imgs{i});
    switch(dim)
        case 1
            x = [reshape(imgs{i}(:,:), [1 linhas*colunas])'];

        case 3
            x = [reshape(imgs{i}(:,:,1), [1 linhas*colunas])' ...
                reshape(imgs{i}(:,:,2), [1 linhas*colunas])' ...
                reshape(imgs{i}(:,:,3), [1 linhas*colunas])' ];

        otherwise
            erro('1 or 3 chanel only');
    end
    
        
    if exist('isTest') & isTest
        dados.x = [dados.x; x];
    else
        x =  unique(x,'rows');
        dados.y = [dados.y; i*ones(size(x,1),1)];
        dados.x = [dados.x; x];
    end
    
end

% 
% dados.x = [];
% dados.y = [];
% for i = 1 : size(imgs,2)
%     x = [];
%     
%     % Percorre cada pixel
%     [linhas colunas ~] = size(imgs{i});
%     for lin = 1 : linhas
%         for col = 1 : colunas
%             
%             x = [x; [imgs{i}(lin, col, 1) ...
%                 imgs{i}(lin, col, 2) imgs{i}(lin, col, 3)]];
%         end
%     end
%     
%     if (strcmp(tipo, 'teste') == 1)
%         dados.x = [dados.x; x];
%     else
%         x =  unique(x,'rows');
%         dados.y = [dados.y; i*ones(size(x,1),1)];
%         dados.x = [dados.x; x];
%     end
% end

dados.x =  double(dados.x);

if exist('isTest') & isTest
    [x, ~, ic] =  unique(dados.x,'rows');
    dados.x = x;
    dados.ic = ic;
end

end

