clear; close all; clc;

img = imread('lena.jpg');
[ca,ch,cv,cd] = dwt2(img,'haar');

figure, imagesc(ca); title('CA'); colormap gray;
figure, imagesc(ch); title('CH'); colormap gray;
figure, imagesc(cv); title('CV'); colormap gray;
figure, imagesc(cd); title('CD'); colormap gray;

%https://www.youtube.com/watch?v=5jxegooGke4