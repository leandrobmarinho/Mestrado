function [ output_args ] = imMultiThresholding( im, a, b )
%IMMULTITHRESHOLDING Summary of this function goes here
%   Detailed explanation goes here

[a l] = size(im);
im2 = im;
for a=1:a
    for b=1:l
        if im(a, b) >= l1 & im(a, b) <= l2
            im2(a, b) = 1;
        else
            im2(a, b) = 0;
        end
    end
end
im2 = logical(im2);
end


end

