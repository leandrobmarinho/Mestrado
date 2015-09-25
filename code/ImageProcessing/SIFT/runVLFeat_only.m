clear all; close all; clc;
p = path; path(p, '../');


nnThreshold = 0.8 ;


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
    
    [~, descr] = vl_sift(single(rgb2gray(imgsTrain{i})));
    descrs{i} = descr;
    
end
timeTrain = toc;

fprintf('Test\n');
% Test
tic
imT = imread('/Users/leandrobm/Documents/robohomegopro/P05_25.JPG') ;
[~, descrsT] = vl_sift(single(rgb2gray(imT)));
descrsT = descrsT;

for i = 1 : 15
    
    [~, scores] = vl_ubcmatch(descrsT, descrs{i});
    
    
%     [nn, dist2] = findNeighbours(descrsT, descrs{i}, 2) ;
%     ratio = dist2(1,:) ./ dist2(2,:) ;
%     ok = ratio <= nnThreshold^2 ;

    numIndex(i) = sum(ok);
end

[~, lbs] = sort(numIndex, 'descend');
lbs(1)

timeTest = toc;



path(p);