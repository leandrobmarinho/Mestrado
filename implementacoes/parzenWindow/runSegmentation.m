clear all; close all;  clc; addpath('..');

%% CARREGA ARQUIVO
imgIn = imread('japao.png');
figure, imshow(imgIn);

numClasse = 2;
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
dadosTrein = img2Dados(imgSelec, '');

imagem{1} = imgIn;
dadosTeste = img2Dados(imagem, 'teste');


%% Utilizando o classificador
[modelo] = trainPzWin(dadosTrein);
[Yh] = testePzWin(modelo, dadosTeste, 1);



%% Convertendo a resposta em imagem
[linhas colunas ~] = size(imgIn);

% Yh(find(Yh == 1)) = 0;
% Yh(find(Yh == 2)) = 255;
newImg = reshape(Yh,[linhas,colunas]);
figure
image(newImg), colormap('flag')
