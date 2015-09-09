addpath('..'); close all; clear all; clc;

imgRGB = imread('../../../../Documents/robohomegopro/P02_03.JPG');
% imageHSV = rgb2hsv(imageRGB);
% imageHSV = imageHSV(:,:,1);
imgGray = rgb2gray(imgRGB);

img = single(imgGray);
lbp = vl_lbp(img, min(size(img))); 
lbp = reshape(lbp, numel(lbp),1)';