clear; close all; clc;
p = path; path(p, '../');


nnThreshold = 0.9 ;
numClasses = 15;

for z = 1 : 10
    fprintf('Train SURF %d\n', z);
    
    % Train
    tic
    
    for i = 1 : numClasses
%         imgsTrain{i} = imread(sprintf('/Users/WELL/Documents/Leandro/Omni_real/classe %02d/Omn%02d_%02d.jpg', i, i, randperm(50,1)));
        imgsTrain{i} = imread(sprintf('/Users/leandrobm/Documents/robohomeomni/classe %02d/Omn%02d_%02d.jpg', i, i, randperm(50,1)));
        
        points = detectSURFFeatures(rgb2gray(imgsTrain{i}));
        [framesTrain{i}, ~] = extractFeatures(rgb2gray(imgsTrain{i}), points);
        
    end
    timeTrain(z) = toc;
    
    fprintf('Test SURF %d\n', z);
    % Test
    tic
    
    classe = randperm(numClasses, 1);
%     imT = imread(sprintf('/Users/WELL/Documents/Leandro/Omni_real/classe %02d/Omn%02d_%02d.jpg', classe, classe, randperm(50, 1))) ;
    imT = imread(sprintf('/Users/leandrobm/Documents/robohomeomni/classe %02d/Omn%02d_%02d.jpg', classe, classe, randperm(50, 1))) ;
    points = detectSURFFeatures(rgb2gray(imT));
    [frameT, ~] = extractFeatures(rgb2gray(imT), points);
    
    for i = 1 : 15
        
        indexPairs = matchFeatures(frameT, framesTrain{i});
        
        numIndex(i) = size(indexPairs,1);
    end
    
    [~, lbs] = sort(numIndex, 'descend');
        
    timeTest(z) = toc;
    
    fprintf('%d\n', lbs(1) == classe);
    hits(z) = lbs(1) == classe;
end

save('surf_tempo_real', 'timeTest', 'timeTrain', 'hits');
fprintf('Acertos %f\n', mean(hits));
path(p);
