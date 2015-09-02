function [histogram] = imhist2( img )
%IMHIST2 Summary of this function goes here
%   Detailed explanation goes here

if (~isa(img, 'uint8'))
   error('Only uint8')
end

range = 0:255;
for i = range

    histogram(i+1) = sum(sum(img == i));
end


bar(range,histogram, 0.4);
axis([0 length(histogram)-1 0 max(histogram)]);
set(gca,'XTick', 0:50:length(histogram)-1);

