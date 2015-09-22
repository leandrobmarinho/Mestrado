close all; clear; clc;
p = path;
path(p, '../../img');
% http://www.cs.uregina.ca/Links/class-info/425/Lab3/


img = imread('cameraman.tif');
imgD = im2double(img);


%% Gamma Transformation
c = 1;
gamma = 2.25;
imgGamma = c*imgD.^gamma;
figure, imshow(img)
figure, imshow(imgGamma)
figure, imhist(imgGamma)


%% Linear Transformation
a = 1;
b = 50;
imgT = a*img + b;
figure, imshow([img imgT])


%% logarithmic Transformation 
c = 5;
imgLog=c*log(1+imgD);
imshow(imgLog), figure
imhist(imgLog), figure



path(p);