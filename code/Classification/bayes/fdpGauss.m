function [ output ] = fdpGauss(x, media, covar )
%FDPGAUSS Summary of this function goes here
%   Detailed explanation goes here

l = size(x,2);

output = sum( (1/((2*pi)^(l/2)*det(covar)^(l/2)))*...
exp(-1/2*(x - repmat(media, size(x,1), 1))*pinv(covar)*(x - repmat(media, size(x,1), 1))') )';
end

