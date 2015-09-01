
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
%     mask = fspecial('average', i);
%     h = imfilter(img,mask);
%     subplot(2, 3, j)
%     imshow(h)
%     j = j + 1;
% end
% figure

% Average Filter several times in the same image
% img = imread('quadrinho3.jpg');
% img = rgb2gray(img);
% mask = fspecial('average', 5);
% subplot(2, 3, 1)
% imshow(img)
% j = 2;
% for i = 1 : 25
%     img = imfilter(img,mask);
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
% mask = fspecial('average', 3);
% imgF = imfilter(img,mask);
% for i = 1 : num
%     imgF = imfilter(imgF,mask);
% end
% subplot(1, 2, 1)
% imshow(imgF)
% 
% mask = [1 2 1; 2 4 2; 1 2 1]/16;
% imgF2 = imfilter(img,mask);
% for i = 1 : num
%     imgF2 = imfilter(imgF2,mask);
% end
% subplot(1, 2, 2)
% imshow(imgF2)
% figure, imhist(imgF), figure, imhist(imgF2)


% Average with thresholding
% img = imread('texto_quadrinho3.jpg');
% img = rgb2gray(img);
% 
% mask = fspecial('average', 9);
% imgF = imfilter(img,mask, 'replicate');
% imgT = thresholding(imgF, 200);
% 
% [labelComp totalComp] = bwlabel(imgT);
% imshow(img), figure, imshow(imgT)



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
%         mask = fspecial('gaussian', size, sigma);
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
%         mask = fspecial('gaussian', size, sigma);
%         
%         imgG = imfilter(img,mask);
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
% mask = fspecial('gaussian', 5, 1.5);
% subplot(2,3,1)
% mesh(mask)
% 
% j = 2;
% for i = 1 : 25
%         
%     img = imfilter(img,mask);
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
% Diferença entre as duas máscaras
%lena flores circuito borboleta lua casa
img = imread('moon.jpg');
imgD = double(img);

imshow(img)
m = fspecial2('laplacian2');
imgL = imfilter(imgD, m);

imgL2 = imgL - repmat(min(imgL,2), 1, size(img,2);
imgL2 = imgL2 .* (255./repmat(min(imgL2), size(img,1), 1));

figure, imshow(uint8(imgL))
figure, imshow(uint8(imgL2))
% r = img-f1;

% Filtro Laplaciano aplicado várias vezes



%% Prewitt
% Compara o gradiente da direção x, y e a magnitude

% Compara as 2 maneiras de calcular a magnitude da imagem anterior

% Diferença diferença nas duas maneiras de calcular o Prewitt


%% Sobel
% Compara o gradiente da direção x, y e a magnitude (mesma imagem do
% Prewitt)

% Bordas em 45º

% Filtro da Média antes de detectar borda

% Sobel com Limiarização

% Compara Laplaciano, Prewitt e Sobel


%% Border pixels
% I = imread('texto_quadrinho3.jpg');
% imshow(I)
% mask = fspecial('average', 9);
% J = imfilter(I, mask);
% figure, imshow(J)
% K = imfilter(I, mask, 'replicate');
% figure, imshow(K)


%% ------------------------ HISTOGRAM ------------------------
%% Equalização de histograma
% arroz menina seeds


%moedas
%% Limiarização
% Limiares fixos


% Limiares automáticos
%125 fingerprint

%% Multilimiarização
%[84 124] ice - melhor rgb
%[49 140] alemanha
%[0.4 0.59] floresta - melhor hsv

