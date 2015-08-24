function imgOut = imfilter2(imgIn, kernel)

imgIn = double(imgIn);

[rI,cI] = size(imgIn);
[rK,cK] = size(kernel);
imgOut = zeros(rK+rI-1,cK+cI-1);
rows = 0:rI-1;
cols = 0:cI-1;
for j=1:cK
    for i=1:rK
        w = kernel(i,j);
        if w~=0,
            imgOut(i+rows,j+cols) = imgOut(i+rows,j+cols) + w*imgIn;
        end
    end
end

rows = floor(rK/2) + (1:rI);
cols = floor(cK/2) + (1:cI);
imgOut = uint8(imgOut(rows,cols));