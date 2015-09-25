classdef FFTImg < handle
    %FFTIMG Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        img %image
        H
    end
    
    methods
        function obj = FFTImg(img)
            if (size(img,3) == 3)
                img = rgb2gray(img);
            end
            obj.img = img;
            
        end
        
        function [imgOut,imgSP1,imgSP2]  = filter(obj, typeMasc, D0, varargin)
            imgSP1 = fftshift(fft2( (obj.img)));

            obj.mask(typeMasc, D0, varargin{:});
            
            imgSP2 = imgSP1 .* obj.H;            
            imgOut = ifft2 (fftshift(imgSP2));            
            imgOut = uint8(abs(imgOut));
        end
        
        function mask(obj, typeMasc, D0, params)

            [numRow, numCol] = size (obj.img);
            D = zeros ([numRow, numCol]);
            obj.H = D;
            
            for u = 1 : numRow
                for v = 1 : numCol
                    D(u, v) = sqrt((u - numRow/2)^2 + (v - numCol/2)^2);
                    if strcmp(typeMasc, 'low')
                        if D(u,v) <= D0
                            obj.H(u,v) = 1;
                        else
                            obj.H(u,v) = 0;
                        end
                    elseif strcmp(typeMasc, 'high')
                        if D(u,v) <= D0
                            obj.H(u,v) = 0;
                        else
                            obj.H(u,v) = 1;
                        end
                    elseif strcmp (typeMasc, 'lowgauss')
                        obj.H(u,v) = exp(-((D(u,v)^2)/(2*(D0^2))));
                        
                    elseif strcmp(typeMasc, 'lowbutt')
                        obj.H (u, v) =  1 / (1 + (D(u,v)/D0)^(2*params));
                        
                    elseif strcmp(typeMasc, 'highgauss')
                        obj.H (u, v) = 1 - exp(-((D(u,v)^2)/(2*(D0^2))));
                        
                    elseif strcmp(typeMasc, 'highbutt')
                        obj.H (u, v) = 1 / (1 + (D0/D(u,v))^(2*params));
                    end
                end
            end
        end
        
    end
    
end

