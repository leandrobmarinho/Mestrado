close all; clear all; clc; addpath('KMeans');

%% Carrega a imagem
imgIn = imread('cameraman.tif');
data = img2Dados(imgIn);


%% K-Means
K = 3;
resKMeans = trainKMeans(data.x, K);
Yh = resKMeans.data.y;
Yh = Yh(data.ic);


%% Label2Image
[row col ~] = size(imgIn);
newImg = reshape(Yh, [row, col]);
figure, image(newImg), colormap('lines')
axis off;

