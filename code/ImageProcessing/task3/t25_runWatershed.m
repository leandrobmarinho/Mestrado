clear all; close all; clc;

%% Transformada de Watershed I
img = imread('imgs/watershedImg.png');
imshow(img,'InitialMagnification','fit')
title('Imagem original')

D = bwdist(~img);
figure, imshow(D,[],'InitialMagnification','fit')
title('Transformada da distancia na imagem binaria')
imwrite(mat2gray(D), 'imgsOut/watershedD_I.png')

D = -D;
D(~img) = -Inf;

L = watershed(D);
figure, imshow(L == 0,'InitialMagnification','fit')
title('Fronteira do Watershed')
imwrite(L == 0, 'imgsOut/watershedFronteira_I.png')

rgb = label2rgb(L,'lines');
figure, imshow(rgb,'InitialMagnification','fit')
title('Transformada de Watershed em D')
imwrite(rgb, 'imgsOut/watershedImgSeg_I.png')





%% Transformada de Watershed II
imgIn = imread('imgs/cork.png');
figure, imshow(imgIn)
title('Imagem original')

imgIn = im2bw(imgIn, graythresh(imgIn));
imgIn = imfill(imgIn, 'holes');
imgBW = medfilt2(imgIn,[5 5]);

imgCbw = ~imgBW;
figure, imshow(imgCbw)
title('Complemento da imagem binaria')
imwrite(imgCbw, 'imgsOut/watershedBW_cork.png')

D = bwdist(imgCbw);
figure, imshow(D, [])
title('Transformada da distancia na imagem binaria')
imwrite(mat2gray(D),'imgsOut/watershedD_cork.png')

L = watershed(-D);
w = L == 0;
figure, imshow(w)
title('Fronteira do Watershed')
imwrite(w, 'imgsOut/watershedFronteira_cork.png')

imgSeg = imgBW & ~w;
figure, imshow(imgSeg), colormap('lines')
title('Imagem segmentada com Watershed')
imwrite(imgSeg, lines, 'imgsOut/watershedImgSeg_cork.png')


