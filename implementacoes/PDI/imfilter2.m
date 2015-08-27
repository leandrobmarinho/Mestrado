function [ imgOut ] = imfilter2( imgIn, kernel)
%MEDIANFILT Summary of this function goes here
%   Detailed explanation goes here

imgIn = double(imgIn);

[rI,cI] = size(imgIn);
[rK,cK] = size(kernel);


c = [zeros(floor(cK/2), cI); imgIn; zeros(floor(cK/2), cI)];
c = [zeros(rI+rK-1, floor(rK/2)) c zeros(rI+rK-1, floor(rK/2))];

rows = 0:rK-1;
cols = 0:cK-1;

for i = 1:cI
   for j = 1:rI
       x = c(j+rows,i+cols);
       imgOut(j,i) = sum(sum(x.*kernel));
   end
end

if(isa(imgOut,'uint8'))
    imgOut = uint8(imgOut);
end

end

