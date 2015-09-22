close all; clear all; clc;

%% Fast Fourier Transform (high-pass filter Butterworth)
imgIn = imread ('imgs/lena_gray_256.tif');

fftImg = FFTImg(imgIn);
[imgOut, imgSP1, imgSP2] = fftImg.filter('highbutt', 15, 2);

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

imwrite(fftImg.H, 'imgsOut/butterworth_HPF.png');
imwrite(imgSP2, 'imgsOut/lenna_HPF_But.png');
imwrite(imgOut, 'imgsOut/lenna_But_H_result.png');
figure, surf(fftImg.H), colormap(jet), print('imgsOut/butterworth_HPF_surf','-depsc')



%% Fast Fourier Transform (high-pass filter Gaussian)
imgIn = imread ('imgs/lena_gray_256.tif');

fftImg = FFTImg(imgIn);
[imgOut, imgSP1, imgSP2] = fftImg.filter('highgauss', 15);

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

imwrite(fftImg.H, 'imgsOut/gaussian_HPF.png');
imwrite(imgSP2, 'imgsOut/lenna_HPF_Gaus.png');
imwrite(imgOut, 'imgsOut/lenna_Gaus_H_result.png');
figure, surf(fftImg.H), colormap(jet), print('imgsOut/gaussian_HPF_surf','-depsc')
