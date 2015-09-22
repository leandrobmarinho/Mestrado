function plotTransLinear( c, b )
%PLOTTRANSLINEAR Summary of this function goes here
%   Detailed explanation goes here

rangeA = 0:255;
rangeA = rangeA((c*(0:255) + b)<=255);
rangeB = [rangeA(end) 255 (c*rangeA(end) + b) (c*rangeA(end) + b)];

plot(rangeA, c*rangeA + b, '-', 'LineWidth',3)
hold on
plot(rangeB(1:2), rangeB(3:4), '-', 'LineWidth',3)

str1 = sprintf('c = %d\nb = %d', c, b);
text(200,125,str1, 'FontSize', 18)

axis([0, 255, 0, 260])
set(gca,'XTickMode','manual');
set(gca,'XTick',[0, 255]);
set(gca,'YTick',[0 255]);
set(gca,'fontsize',20)

end

