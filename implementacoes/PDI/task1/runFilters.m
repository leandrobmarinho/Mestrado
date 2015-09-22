close all; clear; clc; addpath('../img/');

% img = imread('tire.tif');
img = imread('seeds.png');
I2=im2double(img);
% imshow(img), figure
% imhist2(img), figure


%% Mean Filter
% % img = [2 2 2 3; 2 1 3 3; 2 2 1 2; 1 3 2 2]; img = uint8(img);
%
% mask = fspecial2('average', 3);
% tic
% H = imfilter2(img,mask);
% toc
%
% tic
% H2 = imfilter(img, mask);
% toc


%% Median Filter
% I = imread('eight.tif');
% J = imnoise(I,'salt & pepper',0.02);
% % J = [2 2 2 3; 2 1 3 3; 2 2 1 2; 1 3 2 2];
%
% tic
% K = medianFilt(J, 3);
% toc
%
% tic
% % K2 = medfilt2(J);
% toc
% figure, imshow(K)


%% Gaussian Filter
% mask = fspecial2('gaussian', 5);
% % mask2 = fspecial('gaussian', 5);
%
% mesh(mask);
% H = imfilter2(img,mask);



%% Laplacian
% m = fspecial2('laplacian2');
% f1 = imfilter2(img, m);
% r = img+f1;
%
% subplot(1,3,1);
% imshow(img);
% subplot(1,3,2);
% imshow(f1, []);
% subplot(1,3,3);
% imshow(r);



%% Prewitt
% img = imread('circuit.tif');
% img = double(img);
% m = fspecial2('prewitt');
% bx = imfilter2(img, m);
% m = m';
% by = imfilter2(img, m);
% b = sqrt(bx.^2 + by.^2);
% 
% imshow(uint8(b))

% img = uint8(img);
% BW2 = edge(I,'Prewitt');
% imshow(BW2);
%% edge()
% op = fspecial('prewitt')/6; % Prewitt approximation to derivative
% x_mask = op';
% y_mask = op;
% 
% scale = 4;
% offset = [0 0 0 0];
% 
% % compute the gradient in x and y direction
% bx = imfilter(img,x_mask,'replicate');
% by = imfilter(img,y_mask,'replicate');
% 
% % compute the magnitude
% b = bx.*bx + by.*by;
% 
% % determine the threshold; see page 514 of "Digital Imaging Processing" by
% % William K. Pratt
% % Determine cutoff based on RMS estimate of noise
% % Mean of the magnitude squared image is a
% % value that's roughly proportional to SNR
% cutoff = scale*mean2(b);
% thresh = sqrt(cutoff);



%% Sobel
% img = imread('circuit.tif');
% img = double(img);
% m = fspecial2('sobel');
% bx = imfilter2(img, m);
% m = m';
% by = imfilter2(img, m);
% b = sqrt(bx.^2 + by.^2);
% 
% imshow(uint8(b))


%% Histogram Equalization
% img = imread('pout.tif');
% imgEq = histeq2(img);
% imshow([img imgEq])



%% Thresholding
imgRGB = imread('fingerprint.jpg');
% img = rgb2hsv(imgRGB); img = img(:,:,1);
% img = rgb2gray(imgRGB);
% img = imgRGB;

[imgT, t] = thresholding(img, 125);
%[84 124] ice - melhor rgb
%[49 140] alemanha
%[0.4 0.59] floresta - melhor hsv
%125 fingerprint

imshow(imgRGB),figure
imshow(img),figure
imhist(img)
figure; imshow(imgT)


%% Gaussian Filter
%http://stackoverflow.com/questions/8204645/implementing-gaussian-blur-how-to-calculate-convolution-matrix-kernel