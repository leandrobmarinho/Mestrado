clear all; close all; clc;

% img = im2double(imread('medtest.png'));

img = imread('mandril_gray.tif');
img = im2double(img(:,:,1));


imshow(img)
[y, x] = ginput(1)
y=round(y(1)); x=round(x(1));

% x=198; y=359;
imgSeg = regiongrowing(img, x, y, 0.15);
figure, imshow(img+imgSeg);

% medtes - 0.15
% 