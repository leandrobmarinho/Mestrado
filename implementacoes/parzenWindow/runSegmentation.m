clear all; close all;  clc; addpath('..');

%% CARREGA ARQUIVO
imgIn = imread('../img/eua3.jpg');
figure, imshow(imgIn);

numClasse = 2; %INDIQUE O NUMERO DE CLASSES
%% Seleciona o conjunto de treinamento
% Use o mouse

for i = 1 : numClasse
    rect = getrect;
    rect = int64(rect);
    imgSelec{i} = imgIn(rect(2):rect(2)+rect(4), rect(1):rect(1)+rect(3), :);
end
figure
subplot(1,numClasse,1)
imshow( imgSelec{1} )
subplot(1,numClasse,2)
imshow( imgSelec{2} )
% subplot(1,numClasse,3)
% imshow( imgSelec{3} )

%% Criando os dados a partir das imagens
fprintf('Criando os dados a partir das imagens...\n')
dadosTrein = img2Dados(imgSelec, '');

imagem{1} = imgIn;

dadosTeste = img2Dados(imagem, 'teste');

h = 20
%% Utilizando o classificador
fprintf('Treinando...\n')
tic
[modelo] = trainPzWin(dadosTrein);
tempoTrein = toc
tic
fprintf('Testando...\n')
[Yh] = testePzWin(modelo, dadosTeste, h);
Yh = Yh(dadosTeste.ic);
tempoTeste = toc


%% Convertendo a resposta em imagem
[linhas colunas ~] = size(imgIn);
% 
% newImg = reshape(Yh,[colunas, linhas])';
newImg = reshape(Yh,[linhas, colunas]);
figure
image(newImg), colormap('lines')
axis off;


somAlerta();