close all; clear; clc;


%% Transformacao Linear
% -------------- Mudanca de brilho --------------
img = imread('imgs/mandril_gray.tif');

c = 0.5;
b = -10;
imgT1 = c.*img + b; imgT1 = uint8(imgT1);
subplot(2,3,1), imshow(img)
subplot(2,3,2), imshow(imgT1)
subplot(2,3,4), imhist(img)
subplot(2,3,5), imhist(imgT1)

b = 150;
imgT2 = c.*img + b; imgT2 = uint8(imgT2);
subplot(2,3,3), imshow(imgT2)
subplot(2,3,6), imhist(imgT2)

imwrite(img, 'imgsOut/mandril_gray.png')
figure, imhist(img), print('imgsOut/mandril_gray_hist','-depsc')
imwrite(imgT1, 'imgsOut/trans_line_brilhoA.png')
figure, imhist(imgT1), print('imgsOut/trans_line_hist_brilhoA','-depsc')
imwrite(imgT2, 'imgsOut/trans_line_brilhoB.png')
figure, imhist(imgT2), print('imgsOut/trans_line_hist_brilhoB','-depsc')


% -------------- Mudanca de constrate --------------
img = imread('imgs/mandril_gray.tif');

b = 70;
c = 0.1; 
imgT1 = c.*img + b; imgT1 = uint8(imgT1);
figure
subplot(2,3,1), imshow(img)
subplot(2,3,2), imshow(imgT1)
subplot(2,3,4), imhist(img)
subplot(2,3,5), imhist(imgT1)

c = 0.9;
imgT2 = c.*img + b; imgT2 = uint8(imgT2);
subplot(2,3,3), imshow(imgT2)
subplot(2,3,6), imhist(imgT2)
imwrite(imgT1, 'imgsOut/trans_line_contrA.png')
figure, imhist(imgT1), print('imgsOut/trans_line_hist_contrA','-depsc')
imwrite(imgT2, 'imgsOut/trans_line_contrB.png')
figure, imhist(imgT2), print('imgsOut/trans_line_hist_contrB','-depsc')


%% Gamma Transformation
img = imread('imgs/cameraman.tif');

c = 1;
gamma = 0.5;
imgG1 = c*im2double(img).^gamma;
subplot(2,3,1), imshow(img)
subplot(2,3,2), imshow(imgG1)
subplot(2,3,4), imhist(img)
subplot(2,3,5), imhist(imgG1)

gamma = 2.25;
imgG2 = c*im2double(img).^gamma;
subplot(2,3,3), imshow(imgG2)
subplot(2,3,6), imhist(imgG2)

imwrite(img, 'imgsOut/cameraman.png')
figure, imhist(img), print('imgsOut/cameraman_hist','-depsc')
imwrite(imgG1, 'imgsOut/trans_gamaA.png')
figure, imhist(imgG1), print('imgsOut/trans_gama_histA','-depsc')
imwrite(imgG2, 'imgsOut/trans_gamaB.png')
figure, imhist(imgG2), print('imgsOut/trans_gama_histB','-depsc')



%% logarithmic Transformation 
img = imread('imgs/cameraman.tif');
c = 2;
imgLog=c*log(1+im2double(img));
subplot(1,2,1), imshow(img)
subplot(1,2,2), imshow(imgLog)


%% Plot - Transformacoes lineares 
figure
plotTransLinear(1, 32)
figure
plotTransLinear(2, 32)
figure
plotTransLinear(1, -32)
figure
plotTransLinear(2, -32)


