addpath('..');clear all;clc; close all;

% Example 1: only one distance (3 pixels)
options.dharalick = 3;                 % 3 pixels distance for coocurrence
imgRGB = imread('../../../../Documents/robohomegopro/P01_03.JPG');
% R = segbalu(I);                    % segmentation
% J = I(:,:,2);                          % green channel
imgHSV = rgb2hsv(imgRGB); imgHSV = imgHSV(:,:,1);

imgGray = rgb2gray(imgRGB);

% [X,Xn] = haralick(J,R,options);    % Haralick features
[X,Xn] = haralick(imgRGB,options);    % Haralick features

% Bio_printfeatures(X,Xn)


% % Example 2: five distances (1,2,...5 pixels)
% options.dharalick = 1:5;               % 3 pixels distance for coocurrence
% I = imread('Examples/ExtraData/chips/testimg1.jpg');            % input image
% R = Bim_segbalu(I);                    % segmentation
% J = I(:,:,2);                          % green channel
% [X,Xn] = Bfx_haralick(J,R,options);    % Haralick features
% Bio_printfeatures(X,Xn)




GLCM2 = graycomatrix(imgGray); %graycomatrix(I,'Offset',[2 0;0 2]); 
stats = GLCM_Features1(GLCM2,0); 
struct2array(stats)