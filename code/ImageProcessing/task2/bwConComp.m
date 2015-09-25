function [ result] = bwConComp( imgIn )
%CONCOMP Summary of this function goes here
%   Detailed explanation goes here

imgIn = double(imgIn);
lbs = unique(imgIn);
imgIn(imgIn == lbs(2)) = 1;

[numRow, numCol] = size(imgIn);

imgOut = [zeros(1, numCol); imgIn; zeros(1, numCol)];
imgOut = [zeros(numRow+2, 1) imgOut zeros(numRow+2, 1)];

i = 1;
count = 2;
for x = 2 : numRow + 1
    for y = 2 : numCol + 1
        if ( imgOut(x,y) == 1)                                   
            
            % Encontra o caminho a partir do pixel
            [imgOut, count] = getPathPixel(sub2ind(size(imgOut), x, y), imgOut, count );
            last(i) = count-1;
            i = i + 1;
        end
    end
end


imgOut = imgOut(2:end-1, 2:end-1);
ini = 2;
for i = 1 : length(last)
    fim = last(i);
    result.PixelIdxList{i} =  find(imgOut >= ini & imgOut <= fim);
    ini = fim + 1;
end
result.ImageSize = [numRow numCol];
result.NumObjects = length(last);

end

