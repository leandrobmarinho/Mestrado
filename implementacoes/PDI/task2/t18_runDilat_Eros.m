clear; close all; clc

img = imread('imgs/horseshoe-19.gif');

%% Elementos estruturantes
se1 = [1 1 0;...
       1 1 0;...
       1 1 0];
   
se2 = [0 0 1 0 0;...
       0 1 1 1 0;...
       1 1 1 1 1;...
       0 1 1 1 0;...
       0 0 1 0 0];
   
se3 = [0 0 1 1 1 0 0;...
       0 1 1 1 1 1 0;...
       1 1 1 1 1 1 1;...
       1 1 1 1 1 1 1;...
       1 1 1 1 1 1 1;...
       0 1 1 1 1 1 0;...
       0 0 1 1 1 0 0;...
       ];   
   
   

   
%% Executa a dilatacao e erosao de se1
imgDilatada1 =  imdilate2(img, se1);
imgErodida1 =  imerode2(img, se1);

%% Executa a dilatacao e erosao de se2
imgDilatada2 =  imdilate2(img, se2);
imgErodida2 =  imerode2(img, se2);

%% Executa a dilatacao e erosao de se3
imgDilatada3 =  imdilate2(img, se3);
imgErodida3 =  imerode2(img, se3);

figure
subplot(2,2,1), imshow(img)
subplot(2,2,2), imshow(imgDilatada1)
subplot(2,2,3), imshow(imgDilatada2)
subplot(2,2,4), imshow(imgDilatada3)
figure
subplot(2,2,1), imshow(img)
subplot(2,2,2), imshow(imgErodida1)
subplot(2,2,3), imshow(imgErodida2)
subplot(2,2,4), imshow(imgErodida3)

imwrite(img, 'imgsOut/img_dil_eros.png')
imwrite(imgDilatada1, 'imgsOut/imgdilatada1.png')
imwrite(imgDilatada2, 'imgsOut/imgdilatada2.png')
imwrite(imgDilatada3, 'imgsOut/imgdilatada3.png')

imwrite(imgErodida1, 'imgsOut/imgErodida1.png')
imwrite(imgErodida2, 'imgsOut/imgErodida2.png')
imwrite(imgErodida3, 'imgsOut/imgErodida3.png')