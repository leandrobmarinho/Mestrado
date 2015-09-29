clear all; close all; clc;

img = im2double(imread('twoObjs.png'));

imshow(img)
[y, x] = ginput(1)
y=round(y(1)); x=round(x(1));

% x=198; y=359;
imgSeg = regiongrowing(img, x, y, 0.2);
figure, imshow(img+imgSeg);

[r, c ] = find(imgSeg == 1);
figure, imshow(img(min(r):max(r), min(c):max(c)))