close all; clear all; clc;


%% Fast Fourier Transform (low-pass filter)
imgIn = imread ('lena2.jpg');
imgIn = rgb2gray(imgIn);

fftImg = FFTImg(imgIn);
[imgOut, imgSP1, imgSP2] = fftImg.filter('lowgauss', 15);

figure, imshow(imgIn)
title('Imagem Original');

imgSP1 = mat2gray(log(abs(imgSP1) + 1));
figure, imshow(imgSP1);
title('Espectro da imagem original');

figure, imshow(fftImg.H)
title('Filtro');

imgSP2 = mat2gray(log(abs(imgSP2) + 1));
figure, imshow(imgSP2);
title('Espectro do resultado do filtro');

figure, imshow(imgOut)
title('Imagem final');

figure, surf(fftImg.H), colormap(jet)



%% 