clear; close all; clc
p = path; path(p, '../task1')

img = imread('objeto2.jpg');

size = 9;
imgF = imfilter(img, ones(size)/sum(sum(ones(size))));

imgHSV = rgb2hsv(imgF);
h = imgHSV(:,:,1);
s = imgHSV(:,:,2);

imgBW = logical(thresholding(h, .6)) & logical(thresholding(s, .7));
% imgBW = logical(im2bw(h, 0.6) & im2bw(h, .7));

figure, imhist(h); print('imgsOut/obj_H_hist','-depsc')
figure, imhist(s); print('imgsOut/obj_S_hist','-depsc')

figure, imshow(h)
figure, imshow(s)

figure, imshow(thresholding(h, 0.6))
figure, imshow(thresholding(s, 0.7))

figure, imshow(imgBW);

figure, imshow(img);
[L Ne] = bwlabel(imgBW);
props = regionprops(L);
hold on
for i=1:length(props)
    if (props(i).Area > 1000)
        rectangle('Position', props(i).BoundingBox, ...
            'EdgeColor', 'g', 'LineWidth', 3);
        plot(props(i).Centroid(1), props(i).Centroid(2),...
            'g*', 'LineWidth', 3);
        
        print('imgsOut/obj_rec','-depsc')
    end
end

imwrite(h, 'imgsOut/obj_H.png')
imwrite(s, 'imgsOut/obj_S.png')
imwrite(L, 'imgsOut/objBW.png')

path(p)