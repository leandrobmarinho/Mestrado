clear all; close all; clc;

%% Hough transform for lines
imgIn  = imread('imgs/street_lines.png');
img = rgb2gray(imgIn);

BW = edge(img,'canny');
figure, imshow(BW);

[H,T,R] = hough(BW);
figure, imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta', 'FontSize',16), ylabel('\rho', 'FontSize',16);
axis on, axis normal, hold on;

P  = houghpeaks(H,2);
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
print('imgsOut/hough_lines_peaks','-depsc'); %saving...

lines = houghlines(BW,T,R,P);
figure, imshow(imgIn), hold on
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','blue');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','black');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

end
print('imgsOut/hough_lines_on_img','-depsc'); %saving...

imwrite(mat2gray(BW), 'imgsOut/hough_lines_BW.png');




%% Hough transform for circles
im = imread('imgs/coins.png');
imgE = edge(im, 'canny', [0.15 0.2]);
imshow(imgE);

thresh = 0.4;
circulos = houghcircles(imgE, 15, 40, thresh);
figure, plotCircles(im, circulos)
print('imgsOut/hough_coinsCircles0_40','-depsc'); %saving...

thresh = 0.45;
circulos = houghcircles(imgE, 15, 40, thresh);
figure, plotCircles(im, circulos)
print('imgsOut/hough_coinsCircles0_45','-depsc'); %saving...

imwrite(imgE, 'imgsOut/coinsCanny.png');


%% Hough transform for circles II
imgRGB = imread('imgs/coloredChips.png');
img = rgb2gray(imgRGB);
imgE = edge(img, 'canny', [0.15 0.2]);
imshow(imgE);

thresh = 0.4;
circulos = houghcircles(imgE, 15, 40, thresh);
figure, plotCircles(imgRGB, circulos)
print('imgsOut/hough_coloredChips','-depsc'); %saving...

imwrite(imgE, 'imgsOut/coloredChipsCanny.png');
