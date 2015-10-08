clear all; close all; clc;

% tic
img = imread('/Users/leandrobm/Documents/robohomegopro/P01_01.JPG');
img = rgb2gray(img);
% 
% % M20 = cent_moment( img, 2, 0);
% % M11 = cent_moment( img, 1, 1);
% % M02 = cent_moment( img, 0, 2);
% % M30 = cent_moment( img, 3, 0);
% % M21 = cent_moment( img, 2, 1);
% % M12 = cent_moment( img, 1, 2);
% % M03 = cent_moment( img, 0, 3);
% 
Mom(1) = cent_moment( img, 2, 0);
Mom(2) = cent_moment( img, 1, 1);
Mom(3) = cent_moment( img, 0, 2);
Mom(4) = cent_moment( img, 3, 0);
Mom(5) = cent_moment( img, 2, 1);
Mom(6) = cent_moment( img, 1, 2);
Mom(7) = cent_moment( img, 0, 3);
% toc



% cent_moment(img,0,0)
toc



% % Calculate Central Moments
% % Format: Moment = Cent_Mom(image, p, q)
% % image = Input Image % p,q = (p+q)th order or moment
% % Author: Olalekan P. Ogunmolu % ? 2012
% function [Central] = centmom(image,p,q)
% Ord_Mom00 = mom(image,0,0);
% Ord_Mom10 = mom(image,1,0);
% Ord_Mom01 = mom(image,0,1);
% x_bar = Ord_Mom10/Ord_Mom00;
% 
% % Calculates X-center of gravity
% y_bar = Ord_Mom01/Ord_Mom00;
% % Calculates Y-center of gravity
% [row, col] = size(image);
% Central = sum(sum( (((1:row)-x_bar)'.^p * ... 
%     ((1:col)-y_bar).^q) .* image ));
% return

