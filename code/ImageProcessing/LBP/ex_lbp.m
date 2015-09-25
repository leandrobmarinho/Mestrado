addpath('..'); close all; clear all; clc;

%%
options.vdiv = 1;                  % one vertical divition
options.hdiv = 1;                  % one horizontal divition
options.semantic = 0;              % classic LBP
options.samples  = 8;              % number of neighbor samples
options.mappingtype = 'u2';        % uniform LBP

imageRGB = imread('../../../../Documents/robohomegopro/P02_03.JPG');
imageHSV = rgb2hsv(imageRGB);
imageHSV = imageHSV(:,:,1);
% figure(1);imshow(imageRGB,[])             % image to be analyzed
imageGray = rgb2gray(imageRGB);

[X,~] = lbp(imageRGB,[],options);        % LBP features
figure(2);bar(X)                   % histogram

%%
% options.vdiv = 1;                  % one vertical divition
% options.hdiv = 1;                  % one horizontal divition
% options.semantic = 0;              % classic LBP
% options.samples  = 8;              % number of neighbor samples
% options.mappingtype = 'ri';        % rotation-invariant LBP
% % I = imread('../img/casa.jpg');     % input image
% % J = I(:,:,2);
% figure(1);imshow(imageGray,[])             % image to be analyzed
% [X,Xn] = lbp(imageGray,[],options);    % LBP features
% bar(X)                             % histogram

%%
% options.vdiv = 1;                  % one vertical divition
% options.hdiv = 1;                  % one horizontal divition
% options.semantic = 1;              % semantic LBP
% options.samples = 8;               % number of neighbor samples
% options.sk      = 0.5;             % angle sampling
% I = imread('../img/casa.jpg');     % input image
% J = I(:,:,2);                      % region of interest (green)
% [X,Xn] = lbp(J,[],options);        % semantic LBP features
% bar(X)                             % histogram


%%
% options.vdiv = 1;                  % one vertical divition
% options.hdiv = 1;                  % one horizontal divition
% options.semantic = 1;              % semantic LBP
% options.samples = 16;              % number of neighbor samples
% options.sk      = 0.5;             % angle sampling
% I = imread('testimg1.jpg');        % input image
% J = I(:,:,2);
% [X,Xn] = lbp(J,[],options);    % semantic LBP features
% bar(X)                             % histogram

%%
% options.vdiv = 1;                  % one vertical divition
% options.hdiv = 1;                  % one horizontal divition
% options.semantic = 1;              % semantic LBP
% options.samples = 8;               % number of neighbor samples
% options.sk      = 0.25;            % angle sampling
% options.weight  = 9;               % angle sampling
% I = imread('testimg1.jpg');        % input image
% J = I(:,:,2);
% [X,Xn] = lbp(J,[],options);    % weighted LBP features
% bar(X)                             % histogram