close all; clear all; clc; addpath('KMeans');

%% ============== Compare RGB - HSV - Gray ==============
K = 3;
img = imread('imgs/lena_color_512.png');
[row col ~] = size(img);

%% ------------- RGB -------------
data = img2Data(img);

% K-Means
resKMeans = trainKMeans(data.x, K);
Yh = resKMeans.data.y;
Yh = Yh(data.ic);

% Label2Image
newImg = reshape(Yh, [row, col]);
figure, image(newImg), colormap(jet(K))
axis off; axis image; print('imgsOut/kmeansRGB','-depsc');  title('RGB');

%% ------------- HSV -------------
imgIn = rgb2hsv(img);
data = img2Data(imgIn);

% K-Means
resKMeans = trainKMeans(data.x, K);
Yh = resKMeans.data.y;
Yh = Yh(data.ic);

% Label2Image
newImg = reshape(Yh, [row, col]);
figure, image(newImg), colormap(jet(K))
axis off; axis image; print('imgsOut/kmeansHSV','-depsc');  title('HSV');


%% ------------- Gray -------------
imgIn = rgb2gray(img);
data = img2Data(imgIn);

% K-Means
resKMeans = trainKMeans(data.x, K);
Yh = resKMeans.data.y;
Yh = Yh(data.ic);

% Label2Image
newImg = reshape(Yh, [row, col]);
figure, image(newImg), colormap(jet(K))
axis off; axis image; print('imgsOut/kmeansGray','-depsc');  title('Gray');





%% ============== Compare K using RGB (lenna) ==============
img = imread('imgs/lena_color_512.png');
imgIn = img;
data = img2Data(imgIn);
[row col ~] = size(imgIn);

figure, imshow(img)
for k = [2 3 10 15]
    
    % K-Means
    resKMeans = trainKMeans(data.x, k);
    Yh = resKMeans.data.y;
    Yh = Yh(data.ic);
    
    % Label2Image
    newImg = reshape(Yh, [row, col]);
    figure, image(newImg), colormap(copper(k))
    axis off; axis image; print(sprintf('imgsOut/kmeansLena%d', k),'-depsc');
    
end




%% ============== Compare K using RGB (boy) ==============
img = imread('imgs/boy.png');

% keyboard
imgIn = img;
% imgIn = rgb2hsv(img);
data = img2Data(imgIn);
[row col ~] = size(imgIn);

figure, imshow(img)
for k = [2 3 10]
    
    % K-Means
    resKMeans = trainKMeans(data.x, k);
    Yh = resKMeans.data.y;
    Yh = Yh(data.ic);
    
    % Label2Image
    newImg = reshape(Yh, [row, col]);
    figure, image(newImg), colormap(copper(k))
    axis off; axis image; print(sprintf('imgsOut/kmeansBoy%d', k),'-depsc');
    
end



%% ============= Dexter =============
img = imread('imgs/uruguai.png');
[row col ~] = size(img);
figure, imshow(img)

data = img2Data(img);
k = 4;
% K-Means
% resKMeans = trainKMeans(data.x, k);
% Yh = resKMeans.data.y;
[idx,C] = kmeans(data.x, k);
Yh = idx;
Yh = Yh(data.ic);

% Label2Image
newImg = reshape(Yh, [row, col]);
figure, image(newImg), colormap(lines)
axis off; axis image; 
imwrite(newImg, lines, 'imgsOut/kmeans_uruguai.png')
