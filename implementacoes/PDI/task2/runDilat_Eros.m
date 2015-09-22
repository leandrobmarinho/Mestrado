clear; close all; clc

img = imread('dog-12.gif');

%% Elementos estruturantes
se1 = [1 1 1;...
       1 1 1;...
       0 0 0];

se2 = [0 0 1 0 0;...
       0 1 1 1 0;...
       1 1 1 1 1;...
       0 1 1 1 0;...
       0 0 1 0 0];
   
se3 = [0 1 0;...
       1 1 1;...
       0 1 0];

   
%% Executa a dilatacao e erosao de se1
imgDilatada1 =  imdilate2(img, se1);
imgErodida1 =  imerode2(img, se1);

%% Executa a dilatacao e erosao de se2
imgDilatada2 =  imdilate2(img, se2);
imgErodida2 =  imerode2(img, se2);

%% Executa a dilatacao e erosao de se3
imgDilatada3 =  imdilate2(img, se3);
imgErodida3 =  imerode2(img, se3);

figure, imshow(img), figure
subplot(2,3,1), imshow(imgDilatada1)
subplot(2,3,2), imshow(imgDilatada2)
subplot(2,3,3), imshow(imgDilatada3)
subplot(2,3,4), imshow(imgErodida1)
subplot(2,3,5), imshow(imgErodida2)
subplot(2,3,6), imshow(imgErodida3)