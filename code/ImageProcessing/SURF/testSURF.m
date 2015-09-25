function [Y, timeTest] = testSURF( trainData, testData, k )
%TESTSURF Test of SURF
% trainData - data train
% testData - test train
% k - number of image model by classes

numTest = length(testData.labels);
numModels = length(trainData.labels);

Y = zeros(1,numTest);
numIndex = zeros(1, numModels);
timeTest = zeros(1, numTest);
for i = 1 : numTest
    tic
    fTest = testData.imgs{i};
    
    for j = 1 : numModels
        fTrain = trainData.imgs{j};

        indexPairs = matchFeatures(fTest, fTrain);
        
        numIndex(j) = size(indexPairs,1);             
                
        fprintf('%d %d \n', i, j);
    end
    [~, lbs] = sort(numIndex, 'descend');
    Y(i) = lbs(1:k);
    timeTest(i) = toc;
end

end