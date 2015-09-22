function [ im2 ] = im_translate(im, x, y)
%IM_TRANSLATE Summary of this function goes here
%   Detailed explanation goes here

%%
[h w] = size(im);
im2 = zeros(h, w);
for i=1:h
    for j=1:w
        i2 = i + y;
        j2 = j + x;
        if i2 <= h & i2 > 0 & j2 <= w & j2 > 0
            im2(i2, j2) = im(i, j);
        end
    end
end
im2 = mat2gray(im2);
end

