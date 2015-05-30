clear all; close all;  clc; addpath('..'); addpath('../KMeans');

%% CARREGA ARQUIVO
imgIn = imread('../img/eua3.jpg');
figure, imshow(imgIn);

numClasse = 3; %INDIQUE O NUMERO DE CLASSES
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
subplot(1,numClasse,3)
imshow( imgSelec{3} )

%% Criando os dados a partir das imagens
fprintf('Criando os dados a partir das imagens...\n')
dadosTrein = img2Dados(imgSelec, '');

imagem{1} = imgIn;

dadosTeste = img2Dados(imagem, 'teste');

%% Utilizando o classificador
conf.k = 3;
conf.epocas = 200;
conf.Ks = [1 1 2];

r = trainKMeans(dadosTeste.x, conf);
[modelo] = trainGausMix(r.data, conf);

[Yh] = testeGausMix(modelo, dadosTeste);
Yh = Yh(dadosTeste.ic);

[linhas colunas ~] = size(imgIn);
 
newImg = reshape(Yh,[linhas, colunas]);
figure
image(newImg), colormap('lines')
axis off;


%% Utilizando o classificador
conf.epocas = 200;
conf.threshold = 10;

conf.Ks = [1 1 1];
tic
[modelo] = trainGausMix(dadosTrein, conf);
tempoTrein = toc
tic
[Yh] = testeGausMix(modelo, dadosTeste);
Yh = Yh(dadosTeste.ic);
tempoTeste = toc

%% Convertendo a resposta em imagem
[linhas colunas ~] = size(imgIn);
 
newImg = reshape(Yh,[linhas, colunas]);
figure
image(newImg), colormap('lines')
axis off;


%%
conf.k = 3;
r = trainKMeans(dadosTeste.x, conf)

atrX = 3; atrY = 2;

cmap = lines(conf.k);
figure
% for i=1: conf.k
%     plot3(r.data.x(r.data.y==i, 1), r.data.x(r.data.y==i, 2), r.data.x(r.data.y==i, 1),  'o', 'Color', cmap(i,:))
%     hold on
% end
subplot(1, 2, 2)
for i=1: conf.k
    plot3(dadosTeste.x(r.data.y==i, 1), dadosTeste.x(r.data.y==i, 2), dadosTeste.x(r.data.y==i, 1),  'o', 'Color', cmap(i,:))
    hold on
end


plot(r.prototypes(:,atrX), r.prototypes(:,atrY), '*k')
