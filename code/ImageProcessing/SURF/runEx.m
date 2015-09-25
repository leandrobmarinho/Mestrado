clear all; close all; clc;

img1 = imread('/Users/leandrobm/Documents/robohomegopro/P01_01.JPG');
img2 = imread('/Users/leandrobm/Documents/robohomegopro/P01_40.JPG');
img3 = imread('/Users/leandrobm/Documents/robohomegopro/P12_40.JPG');
img1 = rgb2gray(img1);
img2 = rgb2gray(img2);
img3 = rgb2gray(img3);

points1 = detectSURFFeatures(img1);
points2 = detectSURFFeatures(img2);
points3 = detectSURFFeatures(img3);


[f1, valid_points1] = extractFeatures(img1, points1);
[f2, valid_points2] = extractFeatures(img2, points2);
[f3, valid_points3] = extractFeatures(img3, points3);


indexPairs = matchFeatures(f1, f2);
indexPairs_ = matchFeatures(f1, f3);