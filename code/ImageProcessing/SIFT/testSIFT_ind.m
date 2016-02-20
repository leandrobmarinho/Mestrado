function [Y, timeTest, output] = testSIFT_ind( model, testData, k, nnThreshold, pathData )
%TESTSIFT Test of SIFT
% model - data train
% testData - test train
% k - number of image model by classes
% nnThreshold - threshold
% pathData

numTest = length(testData.labels);
numModels = length(model.imgs);

Y = zeros(1,numTest);
numIndex = zeros(1, numModels);
timeTest = zeros(1, numTest);
output = [];

inds = 0;
for i = 1 : numTest
    
%     descrsTest = loadDescs(testData.imgs(i));

    % Load only if there is not batch in memory
    indImg = testData.imgs(i);
    if ( sum(inds == indImg) )
        descrsTest = batchDesc{inds == indImg};
    else
        [batchDesc, inds] = loadDescs(indImg, pathData);
        descrsTest = batchDesc{inds == indImg};
    end
    
    tic
    for j = 1 : numModels
        
        descrsTrain = model.imgs{j};

        [~, dist] = findNeighbours(descrsTest, descrsTrain, 2);
        ratio = dist(1,:) ./ dist(2,:);
        ok = ratio <= nnThreshold^2;
        numIndex(j) = sum(ok);
    end

    [~, lbs] = sort(numIndex, 'descend');
    Y(i) = mode(model.labels(lbs(1:k)));
    timeTest(i) = toc;
    
    fprintf('Teste SIFT. %d de %d\n', i, numTest);
    output = [output; lbs];
end

end