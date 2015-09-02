
close all; clear; clc; addpath('../img/');

% coins
% hubble
% bandeiras
% letras
% quadrinhos
% lenna
% girafa
% moedas
% - 'replicate' or 0


%% ------------------------ LOW PASS FILTERS ------------------------
%% Average Filter
% Several kernel size
% img = imread('quadrinho3.jpg');
% img = rgb2gray(img);
% subplot(2, 3, 1)
% imshow(img)
% j = 2 ;
% for i = [5 15 25 35 45]
%     mask = fspecial2('average', i);
%     h = imfilter2(img,mask);
%     subplot(2, 3, j)
%     imshow(h)
%     j = j + 1;
% end
% figure

% Average Filter several times in the same image
% img = imread('quadrinho3.jpg');
% img = rgb2gray(img);
% mask = fspecial2('average', 5);
% subplot(2, 3, 1)
% imshow(img)
% j = 2;
% for i = 1 : 25
%     img = imfilter2(img,mask);
%     if mod(i, 5) == 0
%         subplot(2, 3, j)
%         imshow(img)
%         j = j + 1;
%     end    
% end


% Weighted Average Filter x Average Filter
% img = imread('alfabet.jpg');
% num = 99;
% 
% mask = fspecial2('average', 3);
% imgF = imfilter2(img,mask);
% for i = 1 : num
%     imgF = imfilter2(imgF,mask);
% end
% subplot(1, 2, 1)
% imshow(imgF)
% 
% mask = [1 2 1; 2 4 2; 1 2 1]/16;
% imgF2 = imfilter2(img,mask);
% for i = 1 : num
%     imgF2 = imfilter2(imgF2,mask);
% end
% subplot(1, 2, 2)
% imshow(imgF2)
% figure, imhist(imgF), figure, imhist(imgF2)



%% Median Filter
% Median and Average Filter (noise salt and pepper)
% I = imread('coins.png');
% img = imnoise(I,'salt & pepper', 0.02);
% 
% mask = fspecial2('average', 3);
% imgA = imfilter2(img,mask);
% 
% imgM = medianFilt(img,3);
% 
% subplot(1, 3, 1)
% imshow(I)
% subplot(1, 3, 2)
% imshow(imgA)
% subplot(1, 3, 3)
% imshow(imgM)


% Several kernel size
% img = imread('couple.png');
% img = rgb2gray(img);
% 
% j = 1;
% subplot(2, 3, j)
% imshow(img);
% for i = [3 5 15 25 35]
%     imgM = medianFilt(img,i);
%     
%     j = j + 1;
%     subplot(2, 3, j)
%     imshow(imgM);
% end
% figure


% Median Filter several times in the same image
% img = imread('couple.png');
% img = rgb2gray(img);
% 
% j = 1;
% subplot(2, 3, j)
% imshow(img);
% imgsHist{j} = img;
% for i = 1 : 10    
%     
%     img = medianFilt(img,3);
%     if mod(i, 2) == 0
%         j = j + 1;
%         subplot(2, 3, j)
%         imshow(img);
%         
%         imgsHist{j} = img;
%     end
% end
% 
% % Show the image histograms
% for i = 1:j
%    figure, imhist(imgsHist{i})
% end


%% Filtro Gaussiano
% Several sigma and kernel size
% img = imread('cameraman.tif');
% 
% imshow(img), figure;
% i = 1;
% for size = [5 15 25 35]
%     for sigma = [.5 1 5]
%         mask = fspecial2('gaussian', size, sigma);
%         subplot(4, 3, i)
%         mesh(mask)
%         
%         i = i + 1;
%     end
% end
% figure
% i = 1;
% for size = [5 15 25 35]
%     for sigma = [.5 1 5]
%         mask = fspecial2('gaussian', size, sigma);
%         
%         imgG = imfilter2(img,mask);
%         subplot(4, 3, i);
%         imshow(imgG);
%         
%         i = i + 1;
%     end
% end


% Gaussian Filter several times in the same image
% img = imread('quadrinho3.jpg');
% img = rgb2gray(img);
% 
% mask = fspecial2('gaussian', 5, 1.5);
% subplot(2,3,1)
% mesh(mask)
% 
% j = 2;
% for i = 1 : 25
%         
%     img = imfilter2(img,mask);
%     
%     if mod(i, 5) == 0
%         subplot(2, 3, j)
%         imshow(img);
%         j = j + 1;
%     end
%     
% end


% Gaussian X Average X Median Filters
% img = imread('childrens.png');
% img = rgb2gray(img);
% 
% subplot(2, 2, 1)
% imshow(img)
% 
% size = 5;
% mask = fspecial2('gaussian', size);
% imgF = imfilter2(img,mask);
% subplot(2, 2, 2)
% imshow(imgF)
% 
% mask = fspecial2('average', size);
% imgF = imfilter2(img, mask);
% subplot(2, 2, 3)
% imshow(imgF)
% 
% imgF = medianFilt(img, size);
% subplot(2, 2, 4)
% imshow(imgF)



%% ------------------------ HIGH PASS FILTERS ------------------------
%% Laplaciano
% Difference between two kernels to image enhancement
% img = imread('license-plate3.png');
% img = double(img);
% 
% m = fspecial2('laplacian1');
% imgF = imfilter2(img, m);
% imgFN = imgNormalize(imgF);
% imgL = img - imgF;
% 
% m = fspecial2('laplacian2');
% imgF2 = imfilter2(img, m);
% imgFN2 = imgNormalize(imgF2);
% imgL2 = img - imgF2;
% 
% subplot(2,2,1), imshow(uint8(img))
% subplot(2,2,2), imshow(uint8(imgF2))
% subplot(2,2,3), imshow(uint8(imgL))
% subplot(2,2,4), imshow(uint8(imgL2))


% Laplacian Filter several times in the same image
% img = imread('lenna-blurred.png');
% img = double(img);
% 
% imshow(uint8(img))
% m = fspecial2('laplacian2');
% for i = 1 : 3
%     imgF = imfilter2(img, m);
%     img = img - imgF;
%     
%     figure, imshow(uint8(img));
% end



%% Prewitt
% Compare the gradientes x and y with the magnitude 
% img = imread('house.jpg');
% img = rgb2gray(img);
% img = double(img);
% 
% m = fspecial2('prewitt');
% bx = imfilter2(img, m);
% m = m';
% by = imfilter2(img, m);
% b = sqrt(bx.^2 + by.^2);
% 
% subplot(2,2,1), imshow(uint8(img))
% subplot(2,2,2), imshow(uint8(bx))
% subplot(2,2,3), imshow(uint8(by))
% subplot(2,2,4), imshow(uint8(b))

% Two way to compute the magnitude
% img = imread('house.jpg');
% img = rgb2gray(img);
% img = double(img);
% 
% m = fspecial2('prewitt');
% bx = imfilter2(img, m);
% m = m';
% by = imfilter2(img, m);
% tic
% b1 = sqrt(bx.^2 + by.^2);
% t1 = toc;
% tic
% b2 = abs(bx) + abs(by);
% t2 = toc;
% 
% subplot(1,2,1), imshow(uint8(b1))
% subplot(1,2,2), imshow(uint8(b2))


% Prewitt several times in the same image
% img = imread('house2.jpg');
% img = rgb2gray(img);
% img = double(img);
% 
% for i = 1 : 5
%     m = fspecial2('prewitt');
%     bx = imfilter2(img, m);
%     m = m';
%     by = imfilter2(img, m);
%     img = abs(bx) + abs(by);
% 
%     figure, imshow(uint8(img))
% end


%% Sobel
% Compare the gradientes x and y with the magnitude 
% img = imread('house.jpg');
% img = rgb2gray(img);
% img = double(img);
% 
% m = fspecial2('sobel');
% bx = imfilter2(img, m);
% m = m';
% by = imfilter2(img, m);
% b = sqrt(bx.^2 + by.^2);
% 
% subplot(2,2,1), imshow(uint8(img))
% subplot(2,2,2), imshow(uint8(bx))
% subplot(2,2,3), imshow(uint8(by))
% subplot(2,2,4), imshow(uint8(b))


% Borders in 45º
% img = imread('house.jpg');
% img = rgb2gray(img);
% img = double(img);
% 
% m = fspecial2('sobelD1');
% d1 = imfilter2(img, m);
% m = fspecial2('sobelD2');
% d2 = imfilter2(img, m);
% 
% subplot(1,2,1), imshow(uint8(d1))
% subplot(1,2,2), imshow(uint8(d2))


% Filtro da Média antes de detectar borda
% img = imread('house.jpg');
% img = rgb2gray(img);
% mask = fspecial2('average', 5);
% img = imfilter2(img, mask);
% img = double(img);
% 
% m = fspecial2('sobel');
% bx = imfilter2(img, m);
% m = m';
% by = imfilter2(img, m);
% b = sqrt(bx.^2 + by.^2);
% 
% subplot(2,2,1), imshow(uint8(img))
% subplot(2,2,2), imshow(uint8(bx))
% subplot(2,2,3), imshow(uint8(by))
% subplot(2,2,4), imshow(uint8(b))


% Sobel with thresholding
% img = imread('house.jpg');
% img = rgb2gray(img);
% mask = fspecial2('average', 5);
% imgF = imfilter2(img, mask);
% imgF = double(imgF);
% img = double(img);
% t = 120;
% 
% m = fspecial2('sobel');
% bx = imfilter2(img, m);
% m = m';
% by = imfilter2(img, m);
% b = abs(bx) + abs(by);
% b = uint8(b);
% b1 = thresholding(b, t);
% 
% m = fspecial2('sobel');
% bx = imfilter2(imgF, m);
% m = m';
% by = imfilter2(imgF, m);
% b = abs(bx) + abs(by);
% b = uint8(b);
% b2 = thresholding(b, t);
% 
% subplot(1,2,1), imshow(uint8(b1))
% subplot(1,2,2), imshow(uint8(b2))



% Laplacian X Prewitt X Sobel
% img = imread('circuit.tif');
% img = double(img);
% 
% m = fspecial2('laplacian2');
% imgF = imfilter2(img, m);
% l = img - imgF;
% 
% m = fspecial2('prewitt');
% bx = imfilter2(img, m);
% m = m';
% by = imfilter2(img, m);
% p = abs(bx) + abs(by);
% 
% m = fspecial2('sobel');
% bx = imfilter2(img, m);
% m = m';
% by = imfilter2(img, m);
% s = abs(bx) + abs(by);
% 
% subplot(2, 2, 1), imshow(uint8(imgF))
% subplot(2, 2, 2), imshow(uint8(p))
% subplot(2, 2, 3), imshow(uint8(s))
% subplot(2, 2, 4), imshow(uint8(img))



%% Border pixels
% I = imread('texto_quadrinho3.jpg');
% imshow(I)
% mask = fspecial2('average', 9);
% J = imfilter2(I, mask);
% figure, imshow(J)
% K = imfilter2(I, mask, 'replicate');
% figure, imshow(K)


%% ------------------------ HISTOGRAM ------------------------
%% Histogram Equalization
% img = imread('tire.tif');
% imgEq = histeq2(img);
% figure,imshow([img imgEq])
% figure,histeq2(imgEq);

% img = imread('pout.tif');
% imgEq = histeq2(img);
% figure,imshow([img imgEq])
% figure,histeq2(imgEq);



%moedas
%% Limiarização
% Single Threshold
% img = imread('fingerprint.jpg');
% 
% imshow(img),figure
% imhist2(img), figure
% j = 1;
% for t = [60 80 140 175 180 190]
%     
%     imgT = thresholding(img, t);
%     subplot(2,3,j), imshow(imgT)
%     j = j +1;
% end


%% Multi-threshold
% img = imread('ice.jpg');
% img = rgb2gray(img);
% 
% imgT = thresholding(img, [84 124]);
% 
% imshow(img),figure
% imhist2(img), figure
% imshow(imgT)


% imgRGB = imread('floresta.jpg');
% imgHSV = rgb2hsv(imgRGB);
% imgHSV = imgHSV(:,:,1);
% imgGray = rgb2gray(imgRGB);
% 
% imgT1 = thresholding(imgHSV, [0.4 0.59]);
% imgT2 = thresholding(imgGray, [54 133]);
% 
% imshow(imgHSV),figure
% imhist(imgHSV), figure
% imshow(imgGray),figure
% imhist2(imgGray),figure
% imshow(imgT1), figure
% imshow(imgT2)


% Average with thresholding
% img = imread('texto_quadrinho3.jpg');
% img = rgb2gray(img);
% 
% mask = fspecial2('average', 9);
% imgF = imfilter2(img,mask, 'replicate');
% imgT = thresholding(imgF, 200);
% 
% [labelComp totalComp] = bwlabel(imgT);
% imshow(img), figure, imshow(imgT)


