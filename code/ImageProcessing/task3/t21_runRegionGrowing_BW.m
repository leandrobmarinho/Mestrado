clear all; close all; clc;


%% ------------- Two objects -------------
img = im2double(imread('imgs/twoObjs.png'));
figure, imshow(img), colormap(prism(3))

% [y, x] = ginput(1)
% y=round(y(1)); x=round(x(1));

x=283; y=250;
imgSeg = regiongrowing(img, x, y, 0.2);
figure, imshow(mat2gray(img+imgSeg)), colormap('prism')
hold on
plot(x, y, '.b', 'MarkerSize',20)
print('imgsOut/regGro2Objs','-depsc');



%% ------------- One object -------------
img = im2double(imread('imgs/frog.gif'));
figure, imshow(img)

% [y, x] = ginput(1)
% y=round(y(1)); x=round(x(1));

x=154; y=85;
imgSeg = regiongrowing(img, x, y, 0.2);
figure, imshow(mat2gray(img+imgSeg)), colormap('lines')
hold on
plot(x, y, '.r', 'MarkerSize',20)
print('imgsOut/regGroFrog','-depsc');


img = im2double(imread('imgs/horse.gif'));
figure, imshow(img)

% [y, x] = ginput(1)
% y=round(y(1)); x=round(x(1));

x=133; y=118;
imgSeg = regiongrowing(img, x, y, 0.2);
figure, imshow(mat2gray(img+imgSeg)), colormap('lines')
hold on
plot(x, y, '.r', 'MarkerSize',20)
print('imgsOut/regGroHorse','-depsc');
