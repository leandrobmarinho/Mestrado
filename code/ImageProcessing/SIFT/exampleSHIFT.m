clear; close all; clc;

% Load the two images
% im1 = imread('data/oxbuild_lite/ashmolean_000007.jpg') ;
% im2 = imread('data/oxbuild_lite/ashmolean_000028.jpg') ; % ok
% im3 = imread('data/oxbuild_lite/bodleian_000146.jpg');
% im4 = imread('data/oxbuild_lite/ashmolean_000058.jpg'); % ok
% im5 = imread('data/oxbuild_lite/bodleian_000356.jpg');

im1 = imread('../../Documents/robohomegopro/P01_01.JPG') ;
im2 = imread('../../Documents/robohomegopro/P01_39.JPG') ; % ok
im3 = imread('../../Documents/robohomegopro/P02_20.JPG');
im4 = imread('../../Documents/robohomegopro/P01_25.JPG'); % ok
im5 = imread('../../Documents/robohomegopro/P12_02.JPG');

% Compute SIFT features for each
tic
[frames1, descrs1] = getFeatures(im1, 'peakThreshold', 0.001, 'orientation', false) ;
toc
[frames2, descrs2] = getFeatures(im2, 'peakThreshold', 0.001, 'orientation', false) ;
[frames3, descrs3] = getFeatures(im3, 'peakThreshold', 0.001, 'orientation', false) ;
[frames4, descrs4] = getFeatures(im4, 'peakThreshold', 0.001, 'orientation', false) ;
[frames5, descrs5] = getFeatures(im5, 'peakThreshold', 0.001, 'orientation', false) ;

nnThreshold = 0.9 ;
% Get the matches based on the raw descriptors
tic ;
[nn, dist2] = findNeighbours(descrs1, descrs2, 2) ;
ratio2 = dist2(1,:) ./ dist2(2,:) ;
ok = ratio2 <= nnThreshold^2 ;
matches_raw = [find(ok) ; nn(1,ok)] ;
time_raw = toc ;

tic ;
[nn_3, dist2_3] = findNeighbours(descrs1, descrs3, 2) ;

ratio2_3 = dist2_3(1,:) ./ dist2_3(2,:) ;
ok_3 = ratio2_3 <= nnThreshold^2 ;
matches_raw_3 = [find(ok_3) ; nn_3(1,ok_3)] ;
time_raw_3 = toc ;

tic ;
[nn_4, dist2_4] = findNeighbours(descrs1, descrs4, 2) ;

ratio2_4 = dist2_4(1,:) ./ dist2_4(2,:) ;
ok_4 = ratio2_4 <= nnThreshold^2 ;
matches_raw_4 = [find(ok_4) ; nn_4(1,ok_4)] ;
time_raw_4 = toc ;

tic ;
[nn_5, dist2_5] = findNeighbours(descrs1, descrs5, 2) ;

ratio2_5 = dist2_5(1,:) ./ dist2_5(2,:) ;
ok_5 = ratio2_3 <= nnThreshold^2 ;
matches_raw_5 = [find(ok_5) ; nn_5(1,ok_5)] ;
time_raw_5 = toc ;

sum(ok)
sum(ok_3)
sum(ok_4)
sum(ok_5)

% Count inliers
% [inliers_raw, H_raw] = geometricVerification(frames1,frames2,matches_raw,'numRefinementIterations', 3) ;
% [inliers_raw_3, H_raw_3] = geometricVerification(frames1,frames3,matches_raw_3,'numRefinementIterations', 3) ;
% [inliers_raw_4, H_raw_4] = geometricVerification(frames1,frames4,matches_raw_4,'numRefinementIterations', 3) ;
% [inliers_raw_5, H_raw_5] = geometricVerification(frames1,frames5,matches_raw_5,'numRefinementIterations', 3) ;