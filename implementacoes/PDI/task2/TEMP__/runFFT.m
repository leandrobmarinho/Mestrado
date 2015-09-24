close all; clear; clc;

% % f = zeros(30,30);
% % f(5:24,13:17) = 1;
% % imshow(f,'InitialMagnification','fit')
% % 
% % F = fft2(f,256,256);
% % F2 = log(abs(F));
% % imshow(F2,[-1 5],'InitialMagnification','fit');
% % colormap(jet); colorbar
% 
% 
%Import image
origimage = imread('cameraman','tif');

%Reduce image to 2-D
% origimage = origimage(:,:,1);
% 
% %Plot image
% figure, imagesc(origimage)
% axis square
% colormap gray
% title('Original Image')
% set(gca, 'XTick', [], 'YTick', [])
% 
% %Blur Kernel
ksize = 31;
% % kernel = zeros(ksize);
% 
%Gaussian Blur
s = 3;
m = ksize/2;
[X, Y] = meshgrid(1:ksize);
kernel = (1/(2*pi*s^2))*exp(-((X-m).^2 + (Y-m).^2)/(2*s^2));
% 
% %Display Kernel
% figure, imagesc(kernel)
% axis square
% title('Blur Kernel')
% colormap gray
% 
% 
% 
% %Embed kernel in image that is size of original image
[h, w] = size(origimage);
kernelimage = zeros(h,w);
kernelimage(1:ksize, 1:ksize) = kernel;
% 
% %Perform 2D FFTs
% fftimage = fft2(double(origimage));
% fftkernel = fft2(kernelimage);
% 
% %Set all zero values to minimum value
% fftkernel(fftkernel == 0) = 1e-6;
% 
% %Multiply FFTs
% fftblurimage = fftimage.*kernelimage;
% 
% %Perform Inverse 2D FFT
% blurimage = ifft2(fftblurimage);
% 
% %Display Blurred Image
% % figure, imagesc(blurimage)
% % axis square
% % title('Blurred Image')
% % colormap gray
% % set(gca, 'XTick', [], 'YTick', [])
% 


%Pad image
origimagepad = padimage(origimage, ksize);

%Embed kernel in image that is size of original image + padding
[h1, w1] = size(origimagepad);
kernelimagepad = zeros(h1,w1);

kernelimagepad(1:ksize, 1:ksize) = kernel;

%Perform 2D FFTs
fftimagepad = fft2(origimagepad);
fftkernelpad = fft2(kernelimagepad);

fftkernelpad(fftkernelpad == 0) = 1e-6;

%Multiply FFTs
fftblurimagepad = fftimagepad.*fftkernelpad;

%Perform Reverse 2D FFT
blurimagepad = ifft2(fftblurimagepad);

%Remove Padding
blurimageunpad = blurimagepad(ksize+1:ksize+h,ksize+1:ksize+w);

%Display Blurred Image
figure, imagesc(blurimageunpad)
axis square
title('Blurred Image - with Padding')
colormap gray
set(gca, 'XTick', [], 'YTick', [])