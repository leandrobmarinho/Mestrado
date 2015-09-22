% params:
% Imagem - a imagem original
% Matriz - matriz de transformacao
% Interpolacao - se é 'linear' ou 'vizinhos'
% Mesmo Tamanho - se a imagem de saída deve ser do memso tamanho da imagem original..
function out = transform( imgIn, matrix, interpolation, sameSize )

imsize = size(imgIn);

Inv = inv(matrix);

if sameSize
    % a nova imagem tera o mesmo tamanho da original
    newsize = imsize;
    
    out = zeros(newsize);
    
    for x = 0:newsize(1)-1
        for y = 0:newsize(2)-1
            sample = [x;y;1];
            trans_sample = [1;1;0] + (Inv * sample);
            if strcmp(interpolation,'vizinhos')
                out(x+1,y+1) = resample_nearest(imgIn, trans_sample);
            elseif strcmp(interpolation,'linear')
                out(x+1,y+1) = resample_linear(imgIn, trans_sample);
            else
                error('Interpolacao nao conhecida "%s"',interpolation);
                return
            end
        end
    end
    out = uint8(out);
    
else % samesize = 0
    
    
    ul = [0 0 1]';
    ur = [imsize(1)-1 0 1]';
    lr = [imsize(1)-1 imsize(2)-1 1]';
    ll = [0 imsize(2)-1 1]';
    
    t_ul = matrix * ul;
    t_ur = matrix * ur;
    t_lr = matrix * lr;
    t_ll = matrix * ll;
    
    max_x = max([ t_ul(1) t_ur(1) t_lr(1) t_ll(1) ]);
    min_x = min([ t_ul(1) t_ur(1) t_lr(1) t_ll(1) ]);
    max_y = max([ t_ul(2) t_ur(2) t_lr(2) t_ll(2) ]);
    min_y = min([ t_ul(2) t_ur(2) t_lr(2) t_ll(2) ]);
    
    
    newsize = [ceil(max_x-min_x) ceil(max_y-min_y)];
    out = zeros(newsize);
    
    for x = 0:newsize(1)-1
        for y = 0:newsize(2)-1
            sample = [min_x+x;min_y+y;1];
            trans_sample = [1;1;0] + (Inv * sample);
            if strcmp(interpolation,'vizinhos')
                out(x+1,y+1) = resample_nearest(imgIn, trans_sample);
            elseif strcmp(interpolation,'linear')
                out(x+1,y+1) = resample_linear(imgIn, trans_sample);
            else
                error('Interpolacao nao conhecida "%s"',interpolation);
                return
            end
        end
    end
    out = uint8(out);
    
    
end % samesize

