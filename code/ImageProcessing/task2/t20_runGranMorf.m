clear; close all; clc

img = imread('imgs/house.tif');
img = img(:,:,1);

% Elemento estruturante
se = [0 0 1 0 0;...
       0 1 1 1 0;...
       1 1 1 1 1;...
       0 1 1 1 0;...
       0 0 1 0 0];
   
% se = [0 1 0;...
%        1 1 1;...
%        0 1 0];


%% Executa a dilatacao e erosao
imgDilatada =  imdilate2(img, se);
imgErodida =  imerode2(img, se);

%% Gradiente Morfológico
gm = imgDilatada - imgErodida;

%% Gradiente Interno
gi = img - imgErodida;

%% Gradiente Externo
ge = imgDilatada - img;

subplot(2,2,1), imshow(img)
subplot(2,2,2), imshow(gi)
subplot(2,2,3), imshow(ge)
subplot(2,2,4), imshow(gm)

imwrite(img, 'imgsOut/img_grad_morf.png')
imwrite(gi, 'imgsOut/grad_int.png')
imwrite(ge, 'imgsOut/grad_ext.png')
imwrite(gm, 'imgsOut/grad_morf.png')
