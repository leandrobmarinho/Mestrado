close all; clear all; clc;

I = imread ('lena2.jpg');
if (size(I,3) == 3)
    I = rgb2gray(I);
end

subplot(1,2,1);
imshow (I);

I1 = fft2(I);
I2 = fftshift (I1);

[w, h] = size (I);
GF = zeros ([w, h]);

% This value determines the 'blur' amount:
% The higher it goes, the less the blur is;
% The lower it goes, the more blur there is.
Sig = 25;

for x = 1 : w
    for y = 1 : h
        GF (x, y) = exp (-((x-w/2)^2 + (y-h/2)^2) / (2 * Sig^2));
    end
end


I3 = I2 .* GF;
I4 = ifft2 (fftshift (I3));

subplot(1,2,2);
imshow(abs(I4)/255);


figure, imshow(GF); colormap(gray)

I2 = log(abs(I2));
range(1) = floor(min(min(I2)));
range(2) = floor(max(max(I2)));
figure, imshow(I2,range); colormap(gray); colorbar

I3 = log(abs(I3));
range(1) = floor(min(min(I3)));
range(2) = floor(max(max(I3)));
figure, imshow(I3,range); colormap(gray); colorbar



% imgFFT = log(abs(I2)+1);
% imgFFT = mat2gray(imgFFT);
% figure(3), imshow(imgFFT,[]);