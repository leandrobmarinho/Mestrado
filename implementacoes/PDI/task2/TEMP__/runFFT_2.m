close all; clear; clc;

footBall=imread('football.jpg');
% footBall=footBall(:,:,1); % Grab only the Red component to fake gray scaling
footBall = rgb2gray(footBall);

imshow(footBall)
PQ = paddedsize(size(footBall));
D0 = 0.05*PQ(1);
H = lpfilter('gaussian', PQ(1), PQ(2), D0); % Calculate the LPF
F=fft2(double(footBall),size(H,1),size(H,2)); % Calculate the discrete Fourier transform of the image
LPF_football=real(ifft2(H.*F)); % multiply the Fourier spectrum by the LPF and apply the inverse, discrete Fourier transform
LPF_football=LPF_football(1:size(footBall,1), 1:size(footBall,2)); % Resize the image to undo padding
figure, imshow(LPF_football, [])
% Display the Fourier Spectrum
Fc=fftshift(F); % move the origin of the transform to the center of the frequency rectangle
S2=log(1+abs(Fc)); % use abs to compute the magnitude (handling imaginary) and use log to brighten display
figure, imshow(S2,[])