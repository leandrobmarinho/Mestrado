function [ batchDescr, inds ] = loadDescs( indImg )
%LOADDESCS Summary of this function goes here
%   Detailed explanation goes here

max = 10;
i = 0;

for j = 1 : 60
    inds = i + 1 : i + max;
    
    if ( sum(inds == indImg) )
        load(sprintf('../dados/SIFT_real_gopro/desc_sift_real_gopro_%.2d', j));
%         descr = imgsDescr{inds == indImg};
        batchDescr = imgsDescr;
        break;
    end  
    
    i = i + max;
end

end

