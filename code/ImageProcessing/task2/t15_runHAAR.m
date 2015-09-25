clear; close all; clc;

img = imread('imgs/lena_gray_256.tif');
[ca,ch,cv,cd] = dwt2(img,'haar');

figure, imagesc(ca); colormap gray; print('imgsOut/haar_CA','-depsc')
figure, imagesc(ch); colormap gray; print('imgsOut/haar_CH','-depsc')
figure, imagesc(cv); colormap gray; print('imgsOut/haar_CV','-depsc')
figure, imagesc(cd); colormap gray; print('imgsOut/haar_CD','-depsc')