classdef GeoTrans < handle
    %GEOTRANS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        img
    end
    
    methods
        function obj = GeoTrans(img)
            obj.img = img;
        end
        
        function out = transform(obj, operation, params, interpolation, sameSize )
            
            imsize = size(obj.img);
            
            if (strcmp(operation, 'rotate'))
                matrix = makeRotate( params(1) );
                
            elseif (strcmp(operation, 'translate'))
                matrix = makeTranslate(params(1), params(2));
                
            elseif (strcmp(operation, 'scaling'))
                matrix = makeScaling(params(1), params(2));
            end
            keyboard
            % inverte a matriz:
            Inv = inv(matrix);
            
            if sameSize
                % a nova imagem tera o mesmo tamanho da original
                newsize = imsize;
                
                out = zeros(newsize);
                
                for x = 0:newsize(1)-1
                    for y = 0:newsize(2)-1
                        sample = [x;y;1];
                        trans_sample = [1;1;0] + (Inv * sample);
                        if strcmp(interpolation,'nearest')
                            out(x+1,y+1) = resample_nearest(obj.img, trans_sample);
                        elseif strcmp(interpolation,'linear')
                            out(x+1,y+1) = resample_linear(obj.img, trans_sample);
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
                
                t_ul = operation * ul;
                t_ur = operation * ur;
                t_lr = operation * lr;
                t_ll = operation * ll;
                
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
                        if strcmp(interpolation,'nearest')
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
            
            
            function out = resample_linear( Image, index )
                
                if index(1) < 1 || index(1) > size(Image,1) || index(2) < 1 || index(2) > size(Image,2)
                    out = 0;
                    return
                end
                
                ul = floor(index);
                lr = ceil(index);
                ur = [lr(1); ul(2); 1];
                ll = [ul(1); lr(2); 1];
                
                x = index(1)-ul(1);
                y = index(2)-ul(2);
                
                out = Image(ul(1),ul(2))*(1-x)*(1-y)...
                    +Image(ur(1),ur(2))*x*(1-y)...
                    +Image(ll(1),ll(2))*(1-x)*y...
                    +Image(lr(1),lr(2))*x*y;
            end
            
            
            function out = resample_nearest( Image, index )
                
                if index(1) < 1 || index(1) > size(Image,1) || index(2) < 1 || index(2) > size(Image,2)
                    out = 0;
                    return
                end
                
                loc = round(index(1:2));
                out = Image(loc(1),loc(2));
            end
            
            function [M] = makeTranslate( tx, ty )
                M = [ 1 0 tx; 0 1 ty; 0 0 1 ];
            end
            
            function [M] = makeRotate( Deg )
                Rad = (pi/180) * Deg;
                M = [ cos(Rad) sin(Rad) 0; -sin(Rad) cos(Rad) 0; 0 0 1 ];
            end
            
            function [M] = makeScaling( sx, sy )
                M = [ sx 0 0; 0 sy 0; 0 0 1 ];
            end
        end
        
    end
end
