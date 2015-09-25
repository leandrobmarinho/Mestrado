clt

% Example 1: only one distance (3 pixels)
options.dharalick = 3;                 % 3 pixels distance for coocurrence
I = imread('Examples/ExtraData/chips/testimg1.jpg');            % input image
R = Bim_segbalu(I);                    % segmentation
J = I(:,:,2);                          % green channel
[X,Xn] = Bfx_haralick(J,R,options);    % Haralick features
Bio_printfeatures(X,Xn)


% % Example 2: five distances (1,2,...5 pixels)
% options.dharalick = 1:5;               % 3 pixels distance for coocurrence
% I = imread('Examples/ExtraData/chips/testimg1.jpg');            % input image
% R = Bim_segbalu(I);                    % segmentation
% J = I(:,:,2);                          % green channel
% [X,Xn] = Bfx_haralick(J,R,options);    % Haralick features
% Bio_printfeatures(X,Xn)