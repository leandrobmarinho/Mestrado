function [ ] = imhist2( img )
%IMHIST2 Summary of this function goes here
%   Detailed explanation goes here

range = double(unique(img))';
for i = range

    histogram(i+1) = sum(sum(img == i));
end

bar(0:length(histogram)-1,histogram, 0.4);
axis([0 length(histogram)-1 0 max(histogram)]);

