function [ Y, timeTest ] = testSURF_ind( trainData, testData, k, pathData )
%TESTSURF_IND Summary of this function goes here
%   Detailed explanation goes here

numTest = length(testData.labels);
numModels = length(trainData.labels);

Y = zeros(1,numTest);
numIndex = zeros(1, numModels);
timeTest = zeros(1, numTest);

inds = 0;
for i = 1 : numTest
    
    % Load only if there is not batch in memory
    indImg = testData.imgs(i);
    if ( sum(inds == indImg) )
        fTest = batchDesc{inds == indImg};
    else
        [batchDesc, inds] = loadDescs(testData.imgs(i), pathData);
        fTest = batchDesc{inds == indImg};
    end
    
    tic
    for j = 1 : numModels
        fTrain = trainData.imgs{j};

        indexPairs = matchFeatures(fTest, fTrain);
        
        numIndex(j) = size(indexPairs,1);
        
                
    end

    [~, lbs] = sort(numIndex, 'descend');
    Y(i) = lbs(1:k);
    timeTest(i) = toc;    
    
    fprintf('%d \n', i);
end

end

