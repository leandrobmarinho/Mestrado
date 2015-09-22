clear; close all; clc;
p = path;p = addpath(p, 'affine_transformation');


%% Translacao
img = imread('imgs/camel.gif');

matrix = makeTranslate(70, 50);
imgOut = transform( img, matrix, 'linear', true );

subplot(1,2,1), imshow(img)
subplot(1,2,2), imshow(imgOut)


%% Mudança de escala
matrix = makeScale(.5,.5);
imgOut = transform( img, matrix, 'linear', false );
figure, imshow(imgOut)

% Rotate
matrix = makeRotate(50);
imgOut = transform( img, matrix, 'vizinhos', false );
% figure, imshow(imgOut)
figure
subplot(1,2, 1), imshow(imgOut)

matrix = makeRotate(50);
imgOut = transform( img, matrix, 'linear', false );
subplot(1,2, 2), imshow(imgOut)




path(p);