clear all; close all;  clc; addpath('..');

%% CARREGA ARQUIVO
imgIn = imread('italia.jpg');
figure, imshow(imgIn);

numClasse = 3;
%% Seleciona o conjunto de treinamento
% Use o mouse

for i = 1 : numClasse
    rect = getrect;
    rect = int64(rect);
    imgSelec{i} = imgIn(rect(2):rect(2)+rect(4), rect(1):rect(1)+rect(3), :);
end
% figure, imshow( imgSelec{1} )
% figure, imshow( imgSelec{2} )


%% Criando os dados a partir das imagens
fprintf('Criando os dados a partir das imagens...\n')
[imgIndex, dadosTeste.x] = rgb2ind(imgIn, 128);

dadosTrein.x = [];
dadosTrein.y = [];
for i = 1 : size(imgSelec,2)
    [~, x] = rgb2ind(imgSelec{i}, 128);
        
    dadosTrein.x = [dadosTrein.x; x];
    dadosTrein.y = [dadosTrein.y; i*ones(size(x,1),1)];
end

% dadosTrein = img2Dados(imgSelec, '');

% imagem{1} = imgIn;
% dadosTeste = img2Dados(imagem, 'teste');


%% Utilizando o classificador
fprintf('Treinando...\n')
[modelo] = trainPzWin(dadosTrein);
fprintf('Testando...\n')
[Yh] = testePzWin(modelo, dadosTeste, 10);



%% Convertendo a resposta em imagem
imgIndex2 = imgIndex;
for i = 1 : size(dadosTeste,1)
    imgIndex2(find(imgIndex==i)) = Yh(i);
end

figure
image(imgIndex2), colormap('flag')

% [linhas colunas ~] = size(imgIn);
% % 
% newImg = reshape(Yh,[colunas, linhas])';
% figure
% image(newImg), colormap('flag')

somAlerta();