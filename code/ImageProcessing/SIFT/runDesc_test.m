clear all; close all; clc;
p = path; path(p, '../'); path(p, '../utils/');


nnThreshold = 0.9 ;
nameImgs = 'real_gopro';
pathData = '/Users/leandrobm/Documents/dados/SIFT_real_gopro/desc_sift_real_gopro_';


% Carrega
load(sprintf('../dados/descInd_%s', nameImgs));
data.imgs = imgsInd;
data.labels = labels;

[trainData, testData] = shuffleImgs(data, 1);



% Train
[model] = trainSIFT(trainData, pathData);


fprintf('Test\n');
% Test
tic
indImg = testData.imgs(randperm(585,1));
label = testData.labels(randperm(585,1));
[batchDesc, inds] = loadDescs(indImg, pathData);
descrsT = batchDesc{inds == indImg};

for i = 1 : 15
    
    [nn, dist2] = findNeighbours(descrsT, model.imgs{i}, 2) ;
    ratio = dist2(1,:) ./ dist2(2,:) ;
    ok = ratio <= nnThreshold^2 ;

    numIndex(i) = sum(ok);
end

[~, lbs] = sort(numIndex, 'descend');
lbs(1)

timeTest = toc;



path(p);