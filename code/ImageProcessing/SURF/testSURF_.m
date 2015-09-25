function [Y, timeTest] = testSURF_( trainData, testData, k, path )
%TESTSIFT Test of SIFT
% trainData - data train
% testData - test train
% k - number of image model by classes
% path - path to read the image
% nnThreshold - threshold

numTest = length(testData.labels);
numTrain = length(trainData.labels);

Y = zeros(1,numTest);
numIndex = zeros(1, numTrain);
timeTest = zeros(1, numTest);
for i = 1 : numTest
    tic
    img = imread(sprintf('%s%s', path, testData.imgs{i}));
    img = rgb2gray(img);
    
%     [~, descrsTest] = vl_sift(img);
    points = detectSURFFeatures(img);
    [fTest, ~] = extractFeatures(img, points);
    
    for j = 1 : numTrain
        imgTrain = imread(sprintf('%s%s', path, trainData.imgs{j}));
        imgTrain = rgb2gray(imgTrain);
        
%         [~, descrsTrain] = vl_sift(imgTrain);
        points = detectSURFFeatures(imgTrain);
        [fTrain, ~] = extractFeatures(imgTrain, points);

        indexPairs = matchFeatures(fTest, fTrain);
        
        numIndex(j) = size(indexPairs,1);             
                
        fprintf('%d %d \n', i, j);
    end
    [~, lbs] = sort(numIndex, 'descend');
    Y(i) = lbs(1:k);
    timeTest(i) = toc;
end

end