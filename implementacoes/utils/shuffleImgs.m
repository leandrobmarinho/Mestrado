function [trainData, testData] = shuffleImgs( data, k, shuffleTest, varargin)
%SHUFFLEIMGS Divide and Shuffle descriptions and labels images
% data - description and labels of images
% k - number of image model by classes
% shuffleTest - shuffle the test images. Default: true

% ptrn = .1;
if (not(exist('shuffleTest', 'var')))
    shuffleTest = true;
end

trainData.imgs = []; trainData.labels = [];
testData.imgs = []; testData.labels = [];
labelClasse = unique(data.labels);
for i = 1 : length(labelClasse)
    
    ind = find(data.labels == labelClasse(i));
    numClasses = length(ind);
    ind = ind(randperm(numClasses));
    
    trainData.labels = [trainData.labels data.labels(ind(1:k))];
    trainData.imgs = [trainData.imgs data.imgs(ind(1:k))];
    
%     limit = floor(ptrn*numClasses);
    testData.labels = [testData.labels data.labels(ind(k+1:end))];
    testData.imgs = [testData.imgs data.imgs(ind(k+1:end))];
    
end

if (shuffleTest)
    ind = randperm(length(testData.labels));
    
    testData.labels = testData.labels(ind);
    testData.imgs = testData.imgs(ind);
end

end

