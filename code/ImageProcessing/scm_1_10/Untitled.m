clc; clear;

I = imread('circuit.tif');
J = imfilter(I,fspecial('Gaussian',[3 3],0.5),'replicate');


[~,p]=scm(I,J);
struct2array(p)



