clear all; close all; clc;

I = imread('../../../../Documents/robohomegopro/P01_01.JPG') ;
tic
I = single(rgb2gray(I));
tempoConv = toc;

[frames, descrs] = vl_sift(I);

tic

[nn, dist2] = findNeighbours(descrs1, descrs2, 2);
ratio2 = dist2(1,:) ./ dist2(2,:) ;
ok = ratio2 <= nnThreshold^2 ;
matches_raw = [find(ok) ; nn(1,ok)] ;
time_raw = toc ;