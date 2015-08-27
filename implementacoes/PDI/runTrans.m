close all; clear; clc; addpath('../img/');

% http://www.cs.uregina.ca/Links/class-info/425/Lab3/


% img = imread('tire.tif');
img = imread('seeds.png');
I2=im2double(img);
% imshow(img), figure
% imhist(img), figure

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


%% Gamma Transformation
% c = 1;
% gamma = .4;
% % imgGamma = c*I2.^gamma;
% imgGamma = imadjust(img,[],[],gamma);
% imshow(imgGamma), figure
% imhist(imgGamma), figure


%% Contrast stretching
% imgCont = imadjust(img,[.4 .55],[.12 .87]);
% imshow( imgCont ), figure
% imhist( imgCont), figure