function [ cm ] = cent_moment( img, p, q )
%CENT_MOMENT Summary of this function goes here
%   Detailed explanation goes here

img = double(img);
% 
% sz = size( img );
% x = ( 1:sz(2) );
% y = ( 1:sz(1) ).';
% x = x - mean(x);
% y = y - mean(y);
% Mpq = sum( reshape( bsxfun( @times, bsxfun( @times, img, x.^p ), y.^q ), [], 1 ) ); %/




% [M, N] = size(img);
% [x, y] = meshgrid(1:N, 1:M);
%  
% % Turn x, y, and F into column vectors to make the summations a bit
% % easier to compute in the following.
% x = x(:);
% y = y(:);
% img = img(:);
%  
% % DIP equation (11.3-12)
% m.m00 = sum(img);
% % Protect against divide-by-zero warnings.
% if (m.m00 == 0)
%    m.m00 = eps;
% end
% % The other central moments: 
% m.m10 = sum(x .* img);
% m.m01 = sum(y .* img);
% m.m11 = sum(x .* y .* img);
% m.m20 = sum(x.^2 .* img);
% m.m02 = sum(y.^2 .* img);
% m.m30 = sum(x.^3 .* img);
% m.m03 = sum(y.^3 .* img);
% m.m12 = sum(x .* y.^2 .* img);
% m.m21 = sum(x.^2 .* y .* img);




[height, width] = size(img);

% define a co-ordinate system for image 
xgrid = repmat((-floor(height/2):1:ceil(height/2)-1)',1,width);
ygrid = repmat(-floor(width/2):1:ceil(width/2)-1,height,1);

[x_bar, y_bar] = centerOfMass(image,xgrid,ygrid);

% normalize coordinate system by subtracting mean
xnorm = x_bar - xgrid;
ynorm = y_bar - ygrid;

cm = sum(sum((xnorm.^p).*(ynorm.^q).*img));
    cm_00 = sum(sum(image)); %this is same as mu(0,0);
    % normalise moments for scale invariance
    cm = cm/(cm_00^(1+(p+q)/2));
end

function [x_bar, y_bar] = centerOfMass(image,xgrid,ygrid)

    eps = 10^(-6); % very small constant 
    
    x_bar = sum(sum((xgrid.*image)))/(sum(image(:))+eps);
    y_bar = sum(sum((ygrid.*image)))/(sum(image(:))+eps);

end
