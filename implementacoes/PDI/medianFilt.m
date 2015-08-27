function [ imgOut ] = medianFilt( imgIn, kernelSize)
%MEDIANFILT Summary of this function goes here
%   Detailed explanation goes here

imgIn = double(imgIn);

[rI,cI] = size(imgIn);
if (length(kernelSize) == 2)
    rK = kernelSize(1);
    cK = kernelSize(2);
else
    rK = kernelSize;
    cK = kernelSize;
end


c = [zeros(floor(cK/2), cI); imgIn; zeros(floor(cK/2), cI)];
c = [zeros(rI+rK-1, floor(rK/2)) c zeros(rI+rK-1, floor(rK/2))];

rows = 0:rK-1;
cols = 0:cK-1;

for i = 1:cI
   for j = 1:rI
       x = c(j+rows,i+cols);
       imgOut(j,i) = median(reshape(x, 1, rK*cK));
   end
end

imgOut = uint8(imgOut);

end

