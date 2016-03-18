clear; close all; clc;
p = path; path(p, '../');

nnThreshold = 0.8;
numClasses = 15;

for z = 1 : 10
    fprintf('Train SIFT %d\n', z);
    
    % Train
    tic    
    
    for i = 1 : numClasses
%         imgsTrain{i} = imread(sprintf('/Users/WELL/Documents/Leandro/Omni_real/classe %02d/Omn%02d_%02d.jpg', i, i, randperm(50,1)));
        imgsTrain{i} = imread(sprintf('/Users/leandrobm/Documents/robohomeomni/classe %02d/Omn%02d_%02d.jpg', i, i, randperm(50,1)));

        [~, descr] = vl_sift(single(rgb2gray(imgsTrain{i})));
        descrs{i} = single(descr);
        
    end
    timeTrain(z) = toc;
    
    fprintf('Test SIFT %d\n', z);
    % Test
    tic
    
    classe = randperm(numClasses, 1);
%     imT = imread(sprintf('/Users/WELL/Documents/Leandro/Omni_real/classe %02d/Omn%02d_%02d.jpg', classe, classe, randperm(50, 1))) ;
    imT = imread(sprintf('/Users/leandrobm/Documents/robohomeomni/classe %02d/Omn%02d_%02d.jpg', classe, classe, randperm(50, 1))) ;
    [~, descrsT] = vl_sift(single(rgb2gray(imT)));
    descrsT = single(descrsT);
    
    for i = 1 : 15
        
        [nn, dist2] = findNeighbours(descrsT, descrs{i}, 2) ;
        ratio = dist2(1,:) ./ dist2(2,:) ;
        ok = ratio <= nnThreshold^2 ;
        
        numIndex(i) = sum(ok);
    end
    
    [~, lbs] = sort(numIndex, 'descend');
    
    timeTest(z) = toc;
    
    fprintf('%d\n', lbs(1) == classe);

    hits(z) = lbs(1) == classe;
end

save('sift_tempo_real', 'timeTest', 'timeTrain', 'hits');
fprintf('Acertos %f\n', mean(hits));
path(p);
