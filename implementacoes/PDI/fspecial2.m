function [ kernel ] = fspecial2( kernelName, kernelSize, sigma, varargin )
%FSPECIAL2 Summary of this function goes here
%   name 
%       average
%       gaussian
%       laplacian1 [0 1 0; 1 -4 1; 0 1 0]
%       laplacian2 [1 1 1; 1 -8 1; 1 1 1]
%       prewitt    [-1 -1 -1; 0 0 0; 1 1 1]
%       sobel      [1 2 1; 0 0 0; -1 -2 -1];
%   kernelSize
%       3 or [3 3]
%   sigma

if ( exist('kernelSize', 'var') == 1)
    if (length(kernelSize) == 2)
        rK = kernelSize(1);
        cK = kernelSize(2);
    else
        rK = kernelSize;
        cK = kernelSize;
    end
end



%% Median Kernel

switch kernelName
    case 'average'
        kernel = ones(rK, cK);
        kernel = (1/sum(sum(kernel)))*kernel;
        
    case 'gaussian'
        if ( exist('sigma', 'var') == 0)
            sigma = .5;
        end
        [h1, h2] = meshgrid(-(rK-1)/2:(rK-1)/2, -(cK-1)/2:(cK-1)/2);
        hg = exp(- (h1.^2+h2.^2) / (2*sigma^2));
        kernel = hg ./ sum(hg(:));
        
    case 'laplacian1'
        kernel = [0 -1 0; -1 4 -1; 0 -1 0];
        
    case 'laplacian2'
        kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1];
        
    case 'prewitt'
        kernel = [-1 -1 -1; 0 0 0; 1 1 1];
        
    case 'sobel'
        kernel = [1 2 1; 0 0 0; -1 -2 -1];
        
    case 'sobelD1'
        kernel = [0 1 2; -1 0 1; -2 -1 0];
        
    case 'sobelD2'
        kernel = [-2 -1 0; -1 0 1; 0 1 2];
end

end

