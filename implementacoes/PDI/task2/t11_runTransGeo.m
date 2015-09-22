clear; close all; clc;
p = path;p = addpath(p, 'affine_transformation');


%% Translacao
img = imread('imgs/camel.gif');

matrix = makeTranslate(70, 50);
imgOut = transform( img, matrix, 'linear', true );

subplot(1,2,1), imshow(img)
subplot(1,2,2), imshow(imgOut)

imwrite(img, 'imgsOut/camel.png')
imwrite(imgOut, 'imgsOut/camelTrans.png')


%% Mudança de escala
img = imread('imgs/tree.gif');

matrix = makeScale(.5,.5);
imgOut1 = transform( img, matrix, 'vizinhos', false );
imgOut2 = transform( img, matrix, 'linear', false );

subplot(1,3,1), imshow(img)
subplot(1,3,2), imshow(imgOut1)
subplot(1,3,3), imshow(imgOut2)

imwrite(img, 'imgsOut/tree.png')
imwrite(imgOut1, 'imgsOut/treeScalingViz.png')
imwrite(imgOut2, 'imgsOut/treeScalingBiliear.png')


% Rotate
img = imread('imgs/butterfly.gif');

matrix = makeRotate(50);
imgOut1 = transform( img, matrix, 'vizinhos', false );

matrix = makeRotate(50);
imgOut2 = transform( img, matrix, 'linear', false );

subplot(1,3,1), imshow(img)
subplot(1,3,2), imshow(imgOut1)
subplot(1,3,3), imshow(imgOut2)

imwrite(img, 'imgsOut/butterfly.png')
imwrite(imgOut1, 'imgsOut/butterflyRotViz.png')
imwrite(imgOut2, 'imgsOut/butterflyRotBiliear.png')



path(p);