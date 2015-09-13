function [model, timeTrain] = trainSIFT( trainData, path )
%TRAINSIFT Train of SIFT. 
% trainData - data train
% k - number of image model by classes
% path - path to read the image
% nnThreshold - threshold

numTrain = length(trainData.labels);

timeTrain = zeros(1, numTrain);
for i = 1 : numTrain
    tic
    img = imread(sprintf('%s%s', path, trainData.imgs{i}));
    img = single(rgb2gray(img));
    
    [~, descrsTrain] = vl_sift(img);
    model.descrs{i} = single(descrsTrain);
%         [~, descrsTest] = getFeatures(img);
    timeTrain(i) = toc;
end
model.labels = trainData.labels;

end