function [model] = trainSIFT( trainData )
%TRAINSIFT Train of SIFT. 
% trainData - data train
% k - number of image model by classes
% path - path to read the image
% nnThreshold - threshold

numTrain = length(trainData.labels);

% timeTrain = zeros(1, numTrain);
% for i = 1 : numTrain
%     tic
%     img = imread(sprintf('%s%s', path, trainData.imgs{i}));
%     img = single(rgb2gray(img));
%     
%     [~, descrsTrain] = vl_sift(img);
%     model.descrs{i} = single(descrsTrain);
%     timeTrain(i) = toc;
% end
% model.labels = trainData.labels;

for i = 1 : numTrain
    
    model.imgs{i} = loadDescs(trainData.imgs(i));
end
model.labels = trainData.labels;

end