clear all; close all; clc;
p = path; path(p, '../');


nnThreshold = 0.9 ;

for z = 1 : 10
    
    % Train
    tic
    
    imgsTrain{1} = imread(sprintf('/Users/leandrobm/Documents/robohomeomni/P01_%.2d.JPG', randperm(40,1)));
    imgsTrain{2} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P02_%.2d.JPG', randperm(40,1)));
    imgsTrain{3} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P03_%.2d.JPG', randperm(40,1)));
    imgsTrain{4} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P04_%.2d.JPG', randperm(40,1)));
    imgsTrain{5} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P05_%.2d.JPG', randperm(40,1)));
    imgsTrain{6} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P06_%.2d.JPG', randperm(40,1)));
    imgsTrain{7} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P07_%.2d.JPG', randperm(40,1)));
    imgsTrain{8} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P08_%.2d.JPG', randperm(40,1)));
    imgsTrain{9} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P09_%.2d.JPG', randperm(40,1)));
    imgsTrain{10} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P10_%.2d.JPG', randperm(40,1)));
    imgsTrain{11} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P11_%.2d.JPG', randperm(40,1)));
    imgsTrain{12} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P12_%.2d.JPG', randperm(40,1)));
    imgsTrain{13} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P13_%.2d.JPG', randperm(40,1)));
    imgsTrain{14} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P14_%.2d.JPG', randperm(40,1)));
    imgsTrain{15} = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P15_%.2d.JPG', randperm(40,1)));
    
    
    for i = 1 : length(imgsTrain)
        
        points = detectSURFFeatures(rgb2gray(imgsTrain{i}));
        [framesTrain{i}, ~] = extractFeatures(rgb2gray(imgsTrain{i}), points);
        
    end
    timeTrain(z) = toc;
    
    fprintf('Test\n');
    % Test
    tic
    imT = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P05_%.2d.JPG', randperm(40,1)));
    points = detectSURFFeatures(rgb2gray(imT));
    [frameT, ~] = extractFeatures(rgb2gray(imT), points);
    
    for i = 1 : 15
        
        indexPairs = matchFeatures(frameT, framesTrain{i});
        
        numIndex(i) = size(indexPairs,1);
    end
    
    [~, lbs] = sort(numIndex, 'descend');
    lbs(1)
    
    timeTest(z) = toc;
end


path(p);