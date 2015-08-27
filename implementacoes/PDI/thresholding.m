function [ imgOut, threshold] = thresholding( imgIn, threshold, varargin )
%THRESHOLDING Summary of this function goes here
%   imgIn - input image
%   threshold
%       double in the range of image or a vector with several thresholds
%       (default) - Global Thresholding with one threshold

isUint8 = false;
Ls = 0;
if (max(imgIn(:)) <= 1)
    Le = 1;
else
    Le = 255;
    isUint8 = true;
end

if ( exist('threshold', 'var') == 1)
    
    sizeT = length(threshold);
    if (sizeT == 1)
        
        imgOut = Le*(imgIn > threshold);
    else
        
        thresholds = [Ls sort(threshold) Le];
        
        labels = (Le-Ls)./(1:sizeT);
        labels = [labels Ls];
        
        [r, c] = size(imgIn);
        imgOut = zeros(r,c);
        for i = 1 : sizeT+1
            Ta = thresholds(i);
            Tb = thresholds(i+1);
            
            img = labels(i)*(imgIn >= Ta & imgIn < Tb);
            imgOut = max(imgOut, img);
        end
        threshold = thresholds(2:end-1);
    end
    
else
    % Compute the threshold automatically
    threshold = mean(imgIn(:));
    
    for i = 1 : 200
        
        m1 = mean(imgIn(imgIn > threshold));
        m2 = mean(imgIn(imgIn <= threshold));
        
        thresholds(i) = (m1 + m2)/2;
        
        if (mean(abs(diff(thresholds))) <= 0.5)
            break;
        end
    end
    imgOut = Le*(imgIn > threshold);
end

if(isUint8)
    imgOut = uint8(imgOut);
end

end