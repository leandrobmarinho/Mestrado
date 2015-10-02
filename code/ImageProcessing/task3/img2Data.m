function [ data ] = img2Data( imgs, withLabel, varargin )
%IMG2DADOS Convert image to data
%
%   data = img2Dados( imgs, withLabel)
%
%   image: a list of images (cell) or one image (uint8)
%   withLabel: with or withou label
%   data (output)


if isa(imgs, 'uint8') || isa(imgs, 'double')
    img = imgs; clear imgs;
    imgs{1} = img;
end

if not(exist('withLabel', 'var'))
    withLabel = false;
end

data.x = [];
if withLabel data.y = []; end
for i = 1 : size(imgs,2)
    
    [rows cols dim] = size(imgs{i});
    switch(dim)
        case 1
            x = [reshape(imgs{i}(:,:), [1 rows*cols])'];
            
        case 3
            x = [reshape(imgs{i}(:,:,1), [1 rows*cols])' ...
                reshape(imgs{i}(:,:,2), [1 rows*cols])' ...
                reshape(imgs{i}(:,:,3), [1 rows*cols])' ];
            
        otherwise
            erro('1 or 3 chanel only');
    end
    
    
    if withLabel
        x =  unique(x,'rows');
        data.y = [data.y; i*ones(size(x,1),1)];
        data.x = [data.x; x];
    else
        data.x = [data.x; x];
    end
    
end
data.x =  double(data.x);

if not(withLabel)
    [x, ~, ic] =  unique(data.x,'rows');
    data.x = x;
    data.ic = ic;
end

end

