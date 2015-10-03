clear all; close all; clc;

%% Medicine
img = im2double(imread('imgs/medtest.png'));

subplot(3,2,6), imshow(img)

% [y, x] = ginput(1)
% y=round(y(1)); x=round(x(1));

x=167; y=348;

imgSeg = regiongrowing(img, x, y, .45);
subplot(3,2,5), imshow(img+imgSeg);
hold on; plot(y, x, '.b', 'MarkerSize',10)

ts = [.15 .3];
for t = 1 : length(ts)
    imgSeg = regiongrowing(img, x, y, ts(t));
    subplot(3,2,(t-1)*2 + 1), imshow(img+imgSeg);
    hold on; plot(y, x, '.b', 'MarkerSize',10)
    subplot(3,2,t*2), imshow(imgSeg);
end

% Saving...
imgSeg = regiongrowing(img, x, y, .45);
figure, imshow(img+imgSeg);
hold on; plot(y, x, '.b', 'MarkerSize',30)
print('imgsOut/regGroMed_45','-depsc');

ts = [.15 .3];
for t = 1 : length(ts)
    imgSeg = regiongrowing(img, x, y, ts(t));
    figure, imshow(img+imgSeg);
    hold on; plot(y, x, '.b', 'MarkerSize',30)
    print(sprintf('imgsOut/regGroMed_%d', ts(t)*100),'-depsc');
    
    figure, imshow(imgSeg);
    print(sprintf('imgsOut/regGroMed_%d_regSeg', ts(t)*100),'-depsc');
end




%% Mandril (Fill hole)
img = im2double(imread('imgs/mandril_gray.png'));

x=201; y=327;
imgSeg1 = regiongrowing(img, x, y, .13);

x2=204; y2=169;
imgSeg2 = regiongrowing(img, x2, y2, .13);

imgSeg = imgSeg1+imgSeg2;
subplot(2,2,1), imshow(img)
subplot(2,2,2), imshow(img+imgSeg1+imgSeg2);
hold on; plot(y, x, '.b', 'MarkerSize',20)
hold on; plot(y2, x2, '.b', 'MarkerSize',20)
subplot(2,2,3), imshow(imgSeg)
% subplot(2,2,4), imshow(imfill(imgSeg, 'holes'))
se = strel('disk',5);
subplot(2,2,4), imshow(imclose(imgSeg, se))


figure, imshow(img+imgSeg1+imgSeg2);
hold on; plot(y, x, '.b', 'MarkerSize',20)
hold on; plot(y2, x2, '.b', 'MarkerSize',20)

print('imgsOut/regGroMandril','-depsc');
imwrite(imgSeg, 'imgsOut/regGroMandrilRegs.png')
se = strel('disk',5);
imwrite(imclose(imgSeg, se), 'imgsOut/regGroMandrilRegsClosing.png')
