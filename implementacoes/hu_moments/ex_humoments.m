addpath('..');clear all;clc; close all;

% RGB_img = imread('../img/casa2.jpg');
imgRGB = imread('../../../../Documents/robohomegopro/P02_03.JPG');

imgHSV = rgb2hsv(imgRGB);
imgHSV = imgHSV(:,:,1);

imgGray = rgb2gray(imgRGB);

img = imgRGB;
[X,~] = hugeo(img)
tic
% X = invmoments(img)
toc
tic
X2 = feature_vec(img)
toc
fprintf('%0.10f',sum((X - X2').^2))