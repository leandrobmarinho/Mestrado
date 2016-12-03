addpath('..');clear;clc; close all;

% Example 1: only one distance (3 pixels)
options.dharalick = 3;                 % 3 pixels distance for coocurrence
imgRGB = imread('/Users/leandrobm/Documents/robohomegopro/P01_03.JPG');
% R = segbalu(I);                    % segmentation
% J = I(:,:,2);                          % green channel
% imgHSV = rgb2hsv(imgRGB); imgHSV = imgHSV(:,:,1);

imgGray = rgb2gray(imgRGB);

% [X,Xn] = haralick(J,R,options);    % Haralick features
tic
[X,Xn] = haralick(imgGray,options);    % Haralick features
toc
X = X(1:13);

% Bio_printfeatures(X,Xn)


% % Example 2: five distances (1,2,...5 pixels)
% options.dharalick = 1:5;               % 3 pixels distance for coocurrence
% I = imread('Examples/ExtraData/chips/testimg1.jpg');            % input image
% R = Bim_segbalu(I);                    % segmentation
% J = I(:,:,2);                          % green channel
% [X,Xn] = Bfx_haralick(J,R,options);    % Haralick features
% Bio_printfeatures(X,Xn)



tic
GLCM2 = graycomatrix(imgGray); %graycomatrix(I,'Offset',[2 0;0 2]); 
stats = GLCM_Features1(GLCM2,0); 
stats = struct2array(stats);
toc

feat = stats([8 2 3 13 11 14 16 15 9 17 18 19 20]);