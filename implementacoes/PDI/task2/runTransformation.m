close all; clear; clc;
p = path;
path(p, '../../img');
% http://www.cs.uregina.ca/Links/class-info/425/Lab3/


% img = imread('tire.tif');
img = imread('cameraman.tif');
I2=im2double(img);
% imshow(img), figure
% imhist(img), figure


%% Gamma Transformation
% c = 1;
% gamma = 2.25;
% imgGamma = c*I2.^gamma;
% figure, imshow(img)
% figure, imshow(imgGamma)
% figure, imhist(imgGamma)


%% Linear Transformation
% a = 1;
% b = 50;
% imgT = a*img + b;
% figure, imshow([img imgT])


%%Negative
% nI = 255 - I;
% nI = imcomplement(img);
% imshow(nI), figure
% imhist(nI), figure
% imhist2(nI), figure


%% logarithmic Transformation 
% c = 5;
% imgLog=c*log(1+I2);
% imshow(imgLog), figure
% imhist(imgLog), figure


%% Contrast stretching
% imgCont = imadjust(img,[.4 .55],[.12 .87]);
% figure, imshow( imgCont )
% figure, imhist( imgCont) 


path(p);