function [F, J] = fun(x, refY, DYh)
    
    for i = 1: size(refY, 1),
        F(i) = norm(x-refY(i, :), 2)^2 - DYh(i)^2;
    end
    
    if nargout > 1   % Two output arguments
        for i = 1: size(refY, 1),
            for j = 1: size(refY, 2),
                J(i, j) = 2*(x(j) - refY(i, j));
            end
        end
    end