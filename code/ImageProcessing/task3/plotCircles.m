function plotCircles(img,  circles )

imshow(img), hold on;
for i = 1:size(circles,1)
    x = circles(i,1)-circles(i,3);
    y = circles(i,2)-circles(i,3);
    w = 2*circles(i,3);
    rectangle('Position', [x y w w], 'EdgeColor', 'blue', 'Curvature', [1 1], ...
        'LineWidth',2);
end
hold off;
end

