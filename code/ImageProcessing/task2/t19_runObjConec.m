close all; clear; clc;
img = imread('imgs/objetos.gif');

%% Computa os componentes conectados na imagem
compConec = bwConComp(img);

numComp = compConec.NumObjects;

figure, imshow(img);
hold on
for i = 1 : numComp
    [r,c] = ind2sub(size(img), compConec.PixelIdxList{i});
    
    rectangle('Position', [min(c) min(r) (max(c) - min(c)) (max(r) - min(r)) ], ...
        'EdgeColor', 'b', 'LineWidth', 3);
    
    
    %% Computa o centroide
    xCentroide = (min(c) + max(c))/2;
    yCentroide = (min(r) + max(r))/2;
    
    plot(xCentroide, yCentroide, 'b*', 'LineWidth', 3);
end

print('imgsOut/obj_conectado','-depsc')