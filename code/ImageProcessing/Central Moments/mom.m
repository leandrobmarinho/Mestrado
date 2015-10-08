function [ ord_mom ] = mom( image,p,q)
%MOM Summary of this function goes here
%   Detailed explanation goes here

image = double(image);
ord_mom = sum(sum( ((1:size(image,1))'.^p *(1:size(image,2)).^q) .* image ));


end

