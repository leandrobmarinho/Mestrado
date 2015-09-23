clear; close all; clc
p = path; path(p, '../task1')

img = imread('hand.jpg');

size = 9;
imgF = imfilter(img, ones(size)/sum(sum(ones(size))));

imgHSV = rgb2hsv(imgF);
h = imgHSV(:,:,1);
s = imgHSV(:,:,2);
v = imgHSV(:,:,3);

imgBW = logical(thresholding(h, [0 0.17])) & logical(thresholding(s, [0.32 0.7]));

figure, imhist(h); print('imgsOut/hand_H_hist','-depsc')
figure, imhist(s); print('imgsOut/hand_S_hist','-depsc')
figure, imhist(v)

figure, imshow(h)
figure, imshow(s)
figure, imshow(v)
figure, imshow(imgBW);

figure, imshow(img);
[L Ne] = bwlabel(imgBW);
props = regionprops(L);
hold on
for i=1:length(props)
    if (props(i).Area > 1000)
        rectangle('Position', props(i).BoundingBox, ...
            'EdgeColor', 'r', 'LineWidth', 3);
        plot(props(i).Centroid(1), props(i).Centroid(2),...
            'r*', 'LineWidth', 3);
        
        print('imgsOut/hand_rec','-depsc')
    end
end

imwrite(h, 'imgsOut/hand_H.png')
imwrite(s, 'imgsOut/hand_S.png')
imwrite(L, 'imgsOut/handBW.png')

path(p)