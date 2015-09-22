function [ imgOut ] = imdilate2( imgIn, se )

% keyboard
[numRow, numCol] = size(imgIn);
sizeSE = size(se, 2);
tSE = ceil(sizeSE/2);

imgIn = double(imgIn);
imgIn = [zeros(tSE, numCol); imgIn; zeros(tSE, numCol)];
imgIn = [zeros(numRow+(tSE*2), tSE) imgIn zeros(numRow+(tSE*2), tSE)];

imgOut = imgIn;
[numRow2, numCol2] = size(imgIn);
for i=tSE:numRow2 - tSE + 1
    for j=tSE:numCol2 - tSE + 1
        
        X = imgIn(i-tSE+1:i+tSE-1,j-tSE+1:j+tSE-1);
        X = X(:);        
        imgOut(i, j) = max(X(logical(se(:))));
    end
end

imgOut = imgOut(tSE+1:numRow+tSE,tSE+1:numCol+tSE);
imgOut = uint8(imgOut);

end


