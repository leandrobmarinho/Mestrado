clear; close all; clc

img = imread('figures2.gif');

[labelComp numComp] = bwlabel(img);
imshow(labelComp); colormap('lines');

hold on
for i=1:numComp
    
    [r,c] = find(labelComp==i);    
    figure, imshow(img(min(r):max(r), min(c):max(c)));

end


%http://www2.ic.uff.br/~aconci/OTSUeOutras.pdf

