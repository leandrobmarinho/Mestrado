
close all; clear; clc; addpath('../img/');


%% ------------------------ LOW PASS FILTERS ------------------------
%% Average Filter
% Several kernel size
% img = imread('quadrinho3.jpg');
% img = rgb2gray(img);
% % subplot(2, 3, 1)
% % imshow(img)
% j = 2 ;
% for i = [5 15 25 35 45]
%     mask = fspecial2('average', i);
%     h = imfilter2(img,mask);
%     
%     %     subplot(2, 3, j)
%     imshow(h)
%     print(sprintf('average_size_%d', i),'-depsc')
%     
%     j = j + 1;
% end
% figure

% Average Filter several times in the same image
% img = imread('quadrinho3.jpg');
% img = rgb2gray(img);
% mask = fspecial2('average', 5);
% % subplot(2, 3, 1)
% % imshow(img)
% j = 2;
% for i = 1 : 50
%     img = imfilter2(img,mask);
%     if mod(i, 10) == 0
%         
% %         subplot(2, 3, j)
%         imshow(img)
%         print(sprintf('average_times_%d', i),'-depsc')
%         
%         j = j + 1;
%     end
% end


% Weighted Average Filter x Average Filter
% img = imread('alfabet.png');
% num = 99;
% 
% mask = fspecial2('average', 3);
% imgF = imfilter2(img,mask);
% for i = 1 : num
%     imgF = fspecial2(imgF,mask);
% end
% % subplot(1, 2, 1)
% imshow(imgF)
% print('average_arithmetic','-depsc')
% 
% mask = [1 2 1; 2 4 2; 1 2 1]/16;
% imgF2 = imfilter2(img,mask);
% for i = 1 : num
%     imgF2 = fspecial2(imgF2,mask);
% end
% % subplot(1, 2, 2)
% imshow(imgF2)
% print('average_weighted','-depsc')
% 
% % figure, imhist2(imgF), figure, imhist2(imgF2)
% imhist2(imgF), colormap('lines')
% print('average_arithmetic_hist','-depsc')
% 
% imhist2(imgF2), colormap('lines')
% print('average_weighted_hist','-depsc')

% Average with thresholding (count words)
% img = imread('texto_quadrinho3.jpg');
% img = rgb2gray(img);
% 
% mask = fspecial2('average', 9);
% imgF = imfilter(img,mask, 'replicate');
% imgT = thresholding(imgF, 200);
% 
% [labelComp totalComp] = bwlabel(imgT);
% figure, imshow(img)
% figure, imshow(imgF)
% figure, imshow(imgT)
% 
% % imwrite(img, 'texto_quadrinho3.png')
% % imwrite(imgF, 'text_average.png')
% % imwrite(imgT, 'text_average_thresholding.png')


%% Median Filter
% Median and Average Filter (noise salt and pepper)
% I = imread('coins.png');
% img = imnoise(I,'salt & pepper', 0.02);
% 
% mask = fspecial2('average', 3);
% imgA = imfilter2(img,mask);
% imgM = medianFilt(img,3);
% 
% imshow(img)
% print('original_m_a','-depsc')
% imshow(imgA)
% print('m_average','-depsc')
% imshow(imgM)
% print('median_a','-depsc')
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
% % subplot(2, 3, j)
% % imshow(img);
% for i = [3 5 15 25 35]
%     imgM = medianFilt(img,i);
% 
%     j = j + 1;
% %     subplot(2, 3, j)
%     imshow(imgM);
%     print(sprintf('median_size_%d', i),'-depsc')
% end
% figure


% Median Filter several times in the same image
% img = imread('couple.png');
% img = rgb2gray(img);
% 
% j = 1;
% % subplot(2, 3, j)
% imshow(img);
% imgsHist{j} = img;
% for i = 1 : 50
% 
%     img = medianFilt(img,[5 5]);
%     if mod(i, 10) == 0
%         j = j + 1;
% %         subplot(2, 3, j)
%         imshow(img);
% %         print(sprintf('median_times_%d', i),'-depsc')
% 
%         imgsHist{j} = img;
%     end
% end
%
%Show the image histograms
% for i = 2:j
% %    figure
%     imhist2(imgsHist{i}), colormap('lines')
% %     print(sprintf('hist_median_times_%d', (i-1)*10),'-depsc')
% end


%% Filtro Gaussiano
% Several sigma and kernel size
% img = imread('cameraman.tif');

% imshow(img), figure;
% i = 1;
% for size = [5 15 25 35]
%     for sigma = [1 5 10]%[.5 1 5]
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
%     for sigma = [1 5 10]
%         mask = fspecial2('gaussian', size, sigma);
% 
%         imgG = imfilter2(img,mask);
%         subplot(4, 3, i);
%         imshow(imgG);
% %         print(sprintf('gaussian_size_%d_%d', size, i),'-depsc')
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
% % print('gaussian_times','-depsc')
% j = 2;
% for i = 1 : 50
% 
%     img = imfilter2(img,mask);
% 
%     if mod(i, 10) == 0
%         subplot(2, 3, j)
%         imshow(img);
% %         print(sprintf('gaussian_times_%d', i),'-depsc')
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
% % imwrite(img, 'comp_original.png')
% 
% size = 7;
% mask = fspecial2('average', size);
% imgF = imfilter2(img, mask);
% subplot(2, 2, 2)
% imshow(imgF)
% % print('comp_average','-depsc')
% 
% imgF = medianFilt(img, size);
% subplot(2, 2, 3)
% imshow(imgF)
% % print('comp_median','-depsc')
% 
% 
% mask = fspecial2('gaussian', size, 1);
% imgF = imfilter2(img,mask);
% subplot(2, 2, 4)
% imshow(imgF)
% % print('comp_gaussian','-depsc')




%% ------------------------ HIGH PASS FILTERS ------------------------
%% Laplacian
% Difference between two kernels to image enhancement
% img = imread('house3.png'); 
% img = rgb2gray(img);
% 
% img = double(img);
% 
% m = fspecial2('laplacian1');
% imgF = imfilter2(img, m);
% imgFN = imgNormalize(imgF);
% imgL = img + imgF;
% 
% m = fspecial2('laplacian2');
% imgF2 = imfilter2(img, m);
% imgFN2 = imgNormalize(imgF2);
% imgL2 = img + imgF2;
% 
% % subplot(2,2,1), imshow(uint8(img))
% % subplot(2,2,2), imshow(uint8(imgF2))
% % subplot(2,2,3), imshow(uint8(imgL))
% % subplot(2,2,4), imshow(uint8(imgL2))
% 
% imshow(uint8(imgF2)); print('laplacian_filter','-depsc')
% imshow(uint8(imgL)); print('laplacian1','-depsc')
% imshow(uint8(imgL2)); print('laplacian2','-depsc')



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
% %     figure, imshow(uint8(img));
%     imshow(uint8(img));
%     print(sprintf('laplacian_times_%d', i),'-depsc')
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
% % b = sqrt(bx.^2 + by.^2);
% b = abs(bx) + abs(by);

% subplot(2,2,1), imshow(uint8(img))
% subplot(2,2,2), imshow(uint8(bx))
% subplot(2,2,3), imshow(uint8(by))
% subplot(2,2,4), imshow(uint8(b))

% imshow(uint8(img)); imwrite(uint8(img), 'house.png')
% imshow(uint8(bx)); print('prewitt_x','-depsc')
% imshow(uint8(by)); print('prewitt_y','-depsc')
% imshow(uint8(b)); print('prewitt_all','-depsc')



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

% subplot(1,2,1), imshow(uint8(b1))
% subplot(1,2,2), imshow(uint8(b2))
% figure, imhist2(uint8(b1));
% figure, imhist2(uint8(b2));

% imshow(uint8(b1)); print('prewitt_comp1','-depsc')
% imshow(uint8(b2)); print('prewitt_comp2','-depsc')
% imhist2(uint8(b1)); colormap('lines'); print('prewitt_comp_hist1','-depsc')
% imhist2(uint8(b2)); colormap('lines'); print('prewitt_comp_hist2','-depsc')



% Prewitt several times in the same image
% img = imread('house2.jpg');
% img = rgb2gray(img);
% img = double(img);
% 
% imwrite(uint8(img), 'house2.png')
% for i = 1 : 5
%     m = fspecial('prewitt');
%     bx = imfilter(img, m);
%     m = m';
%     by = imfilter(img, m);
%     img = abs(bx) + abs(by);
% 
%     figure, imshow(uint8(img))
% %     imshow(uint8(img))
% %     print(sprintf('prewitt_times_%d', i),'-depsc')
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
% % 
% % subplot(2,2,1), imshow(uint8(img))
% % subplot(2,2,2), imshow(uint8(bx))
% % subplot(2,2,3), imshow(uint8(by))
% % subplot(2,2,4), imshow(uint8(b))
% 
% imshow(uint8(img)); imwrite(uint8(img), 'house.png')
% imshow(uint8(bx)); print('sobel_x','-depsc')
% imshow(uint8(by)); print('sobel_y','-depsc')
% imshow(uint8(b)); print('sobel_all','-depsc')


% Borders in 45º
% img = imread('house.jpg');
% img = rgb2gray(img);
% img = double(img);
% 
% m = fspecial2('sobelD1');
% d1 = imfilter2(img, m);
% m = fspecial2('sobelD2');
% d2 = imfilter2(img, m);

% subplot(1,2,1), imshow(uint8(d1))
% subplot(1,2,2), imshow(uint8(d2))
% imshow(uint8(d1)); print('sobel_d1','-depsc')
% imshow(uint8(d2)); print('sobel_d2','-depsc')



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
% % subplot(2,2,1), imshow(uint8(img))
% % subplot(2,2,2), imshow(uint8(bx))
% % subplot(2,2,3), imshow(uint8(by))
% % subplot(2,2,4), imshow(uint8(b))
% 
% imshow(uint8(img)); print('sobel_average_house','-depsc')
% imshow(uint8(bx)); print('sobel_average_bx','-depsc')
% imshow(uint8(by)); print('sobel_average_by','-depsc')
% imshow(uint8(b)); print('sobel_average_b','-depsc')


% Sobel with thresholding and average
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
% % subplot(1,2,1), imshow(uint8(b1))
% % subplot(1,2,2), imshow(uint8(b2))
% imshow(uint8(b1)); print('sobel_limiarizacao1','-depsc')
% imshow(uint8(b2)); print('sobel_limiarizacao2','-depsc')



% Laplacian X Prewitt X Sobel
% img = imread('circuit.tif');
% img = double(img);
% 
% m = fspecial2('laplacian2');
% imgF = imfilter2(img, m);
% l = img + imgF;
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
% % subplot(2, 2, 1), imshow(uint8(imgF))
% % subplot(2, 2, 2), imshow(uint8(p))
% % subplot(2, 2, 3), imshow(uint8(s))
% % subplot(2, 2, 4), imshow(uint8(img))
% 
% imshow(uint8(imgF)); print('comp_laplacian','-depsc')
% imshow(uint8(p)); print('comp_prewitt','-depsc')
% imshow(uint8(s)); print('comp_sobel','-depsc')
% imwrite(uint8(img), 'comp_original_circuito.png')



%% Border pixels
% I = imread('texto_quadrinho3.jpg');
% I = rgb2gray(I);
% imshow(I)
% mask = fspecial2('average', 9);
% J = imfilter2(I, mask);
% figure, imshow(J)
% K = imfilter(I, mask, 'replicate');
% figure, imshow(K)
% 
% imwrite(uint8(I), 'texto_quadrinho.png')
% imshow(J); print('average_0','-depsc')
% imshow(K); print('average_replicate','-depsc')




%% ------------------------ HISTOGRAM ------------------------
%% Histogram Equalization
% img = imread('tire.tif');
% imgEq = histeq2(img);
% % figure,imshow([img imgEq]);
% % figure,imhist2(img);
% % figure,imhist2(imgEq);
% imshow(img); print('tire','-depsc')
% imshow(imgEq); print('tire_eq','-depsc'); colormap('lines')
% imhist2(img); print('tire_hist','-depsc'); colormap('lines')
% imhist2(imgEq); print('tire_hist_eq','-depsc')
% 
% 
% img = imread('pout.tif');
% imgEq = histeq2(img);
% % figure,imshow([img imgEq])
% % figure,imhist2(img);
% % figure,imhist2(imgEq);
% imshow(img); print('pout','-depsc')
% imshow(imgEq); print('pout_eq','-depsc'); colormap('lines')
% imhist2(img); print('pout_hist','-depsc'); colormap('lines')
% imhist2(imgEq); print('pout_hist_eq','-depsc')



%moedas
%% Limiarização
% Single Threshold
% img = imread('fingerprint.jpg');
% 
% % imshow(img),figure
% % imhist2(img), figure
% imhist2(img), colormap('lines')
% print('fingerprint_hist','-depsc')
% 
% j = 1;
% for t = [50 60 140 175 180 190]
% 
%     imgT = thresholding(img, t);
% %     subplot(2,3,j), imshow(imgT)
%     imshow(imgT)
%     print(sprintf('limiarizacao_digital_%d', t),'-depsc')
%     
%     j = j +1;
% end
% [imgTA, t] = thresholding(img);
% 
% imwrite(img, 'fingerprint.png')


%% Average before Thresholding to remove noise
% img = imread('threshold_noise.png');
% img = rgb2gray(img);
% imhist2(img); print('limiarizacao_noise_hist','-depsc')
% figure, imshow(img)
% 
% mask = fspecial2('average', 5);
% imgF = imfilter(img,mask,'replicate');
% figure, imhist2(imgF); print('limiarizacao_noise_average_hist','-depsc')
% figure, imshow(imgF); 
% 
% [imgT1, t1] = thresholding(img);
% [imgT2, t2] = thresholding(imgF);
% 
% figure, imshow(imgT1); print('limiarizacao_noise','-depsc')
% figure, imshow(imgT2); print('limiarizacao_average_noise','-depsc')
% 
% imwrite(imgF, 'threshold_noise_average.png');



%% Multi-threshold
% img = imread('rocha2.jpg');
% img = rgb2gray(img);
% figure, imshow(img)
% figure, imhist2(img)
% imgT = thresholding(img, [84 189]);
% figure, imshow(imgT)
% 
% imwrite(img, 'rocha.png')
% set(gca,'FontSize',20)
% imhist2(img); colormap('lines'); print('rocha_hist','-depsc')
% imshow(imgT); colormap('lines'); print('rocha_limiarizada','-depsc')


% img = imread('ice.jpg');
% img = rgb2gray(img);
% 
% imgT = thresholding(img, [87 122]);
% 
% imshow(img),figure
% imhist2(img), figure
% imshow(imgT)



% img = imread('reggae.jpg');
% img = rgb2gray(img);
% 
% imgT = thresholding(img, [68 113 174]);
% 
% imhist(img)
% figure, imshow(img)
% figure, imshow(imgT)





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
% 
% set(gca,'FontSize',20)
% imwrite(imgGray, 'floresta_gray.png')
% imhist2(imgGray); colormap('lines'); print('floresta_gray_hist','-depsc')
% imwrite(imgHSV, 'floresta_hsv.png')
% imhist(imgHSV); colormap('lines'); print('floresta_hsv_hist','-depsc')
% imshow(imgT1); colormap('lines'); print('floresta_segmentada','-depsc')

