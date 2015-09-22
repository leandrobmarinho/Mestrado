function [ imgOut ] = imgNormalize( imgIn )
%IMGNORMALIZE Summary of this function goes here
%   Detailed explanation goes here

maxRange = 255;

minImg = min(unique(imgIn));

imgOut = imgIn - minImg;
maxImg = max(unique(imgOut));
imgOut = maxRange * (imgOut/maxImg);


end

