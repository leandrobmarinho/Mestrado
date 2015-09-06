function [histogram] = imhist2( img )
%IMHIST2 Summary of this function goes here
%   Detailed explanation goes here

if (~isa(img, 'uint8'))
   error('Only uint8')
end

range = 0:255;
y = zeros(1, length(range));
for i = range

    y(i+1) = sum(sum(img == i));
end

if (nargout == 0)
    bar(range,y, 0.4);
    axis([0 length(y)-1 0 max(y)]);
    set(gca,'XTick', 0:50:length(y)-1);   
else
    histogram = y;
end


