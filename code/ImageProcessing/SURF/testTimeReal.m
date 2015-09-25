clear all; close all; clc;
p = path; path(p, '../');


nnThreshold = 0.9 ;


% Train
tic

imgsTrain{1} = imread('/Users/leandrobm/Documents/robohomegopro/P01_19.JPG') ;
imgsTrain{2} = imread('/Users/leandrobm/Documents/robohomegopro/P02_39.JPG') ;
imgsTrain{3} = imread('/Users/leandrobm/Documents/robohomegopro/P03_20.JPG');
imgsTrain{4} = imread('/Users/leandrobm/Documents/robohomegopro/P04_25.JPG');
imgsTrain{5} = imread('/Users/leandrobm/Documents/robohomegopro/P05_06.JPG');
imgsTrain{6} = imread('/Users/leandrobm/Documents/robohomegopro/P06_32.JPG');
imgsTrain{7} = imread('/Users/leandrobm/Documents/robohomegopro/P07_04.JPG');
imgsTrain{8} = imread('/Users/leandrobm/Documents/robohomegopro/P08_38.JPG');
imgsTrain{9} = imread('/Users/leandrobm/Documents/robohomegopro/P09_05.JPG');
imgsTrain{10} = imread('/Users/leandrobm/Documents/robohomegopro/P10_01.JPG');
imgsTrain{11} = imread('/Users/leandrobm/Documents/robohomegopro/P11_06.JPG');
imgsTrain{12} = imread('/Users/leandrobm/Documents/robohomegopro/P12_11.JPG');
imgsTrain{13} = imread('/Users/leandrobm/Documents/robohomegopro/P13_22.JPG');
imgsTrain{14} = imread('/Users/leandrobm/Documents/robohomegopro/P14_12.JPG');
imgsTrain{15} = imread('/Users/leandrobm/Documents/robohomegopro/P15_08.JPG');


for i = 1 : length(imgsTrain)
    
    points = detectSURFFeatures(rgb2gray(imgsTrain{i}));
    [framesTrain{i}, ~] = extractFeatures(rgb2gray(imgsTrain{i}), points);
        
end
timeTrain = toc;

fprintf('Test\n');
% Test
tic
imT = imread('/Users/leandrobm/Documents/robohomegopro/P05_25.JPG') ;
points = detectSURFFeatures(rgb2gray(imT));
[frameT, ~] = extractFeatures(rgb2gray(imT), points);

for i = 1 : 15
    
    indexPairs = matchFeatures(frameT, framesTrain{i});
        
    numIndex(i) = size(indexPairs,1);   
end

[~, lbs] = sort(numIndex, 'descend');
lbs(1)

timeTest = toc;



path(p);