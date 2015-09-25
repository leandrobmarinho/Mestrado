function [img, i ] = getPathPixel(pixelIni, img, i )
%{
East         M
Southeast    M + 1
South        1
Southwest   -M + 1
West        -M
Northwest   -M - 1
North       -1
Northeast    M - 1
%}


M = size(img, 1);
neighbor_offsets = [-1, M - 1, M, M + 1, 1, -M + 1, -M, -M - 1]';

inds = pixelIni;
img(pixelIni) = i;
i = i + 1;
while not(isempty(inds))
    pixel = inds(1);
    inds = inds(2:end);
    
    neighbors = bsxfun(@plus, pixel, neighbor_offsets);
    isNeighbors = neighbors(img(neighbors) == 1)';
    
    inds = [inds isNeighbors];
    
    if (not(isempty(isNeighbors)))
        img(isNeighbors) = i : i + length(isNeighbors) - 1;
        i = i + length(isNeighbors);
    end

end

end


