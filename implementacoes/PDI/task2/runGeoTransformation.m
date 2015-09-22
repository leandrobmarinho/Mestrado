clear all; close all; clc;

imgIn = imread('lena.png');
figure, imshow(imgIn)

geoTrans = GeoTrans(imgIn);
imgOut = geoTrans.transform('translate', [20 20], 'linear', true);


% matrix = makeTranslate(20, 20);
% imgOut = transform( img, matrix, 'linear', true );
figure, imshow(imgOut)