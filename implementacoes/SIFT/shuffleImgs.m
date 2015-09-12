function [trainData, testData] = shuffleImgs( data, k )
%SHUFFLEIMGS Shuffle descriptions and labels images
% data - description and labels of images
% k - number of image model by classes
ptrn = .4;

trainData.imgs = []; trainData.labels = [];
testData.imgs = []; testData.labels = [];
labelClasse = unique(data.labels);
for i = 1 : length(labelClasse)
    
    ind = find(data.labels == labelClasse(i));
    numClasses = length(ind);
    ind = ind(randperm(numClasses));
    
    trainData.labels = [trainData.labels data.labels(ind(1:k))];
    trainData.imgs = [trainData.imgs data.imgsName(ind(1:k))];
    
    limit = floor(ptrn*numClasses);
    testData.labels = [testData.labels data.labels(ind(k+1:limit))];
    testData.imgs = [testData.imgs data.imgsName(ind(k+1:limit))];
    
end

ind = randperm(length(testData.labels));

testData.labels = testData.labels(ind);
testData.imgs = testData.imgs(ind);

end

