function [Y, timeTest] = testSIFT__( model, testData, k, nnThreshold )
%TESTSIFT Test of SIFT
% model - data train
% testData - test train
% k - number of image model by classes
% nnThreshold - threshold

numTest = length(testData.labels);
numModels = length(model.imgs);

Y = zeros(1,numTest);
numIndex = zeros(1, numModels);
timeTest = zeros(1, numTest);
for i = 1 : numTest
    tic   
    descrsTest = testData.imgs{i};
    
    for j = 1 : numModels
        
        descrsTrain = model.imgs{j};

        
        [~, dist] = findNeighbours(descrsTest, descrsTrain, 2);
        ratio = dist(1,:) ./ dist(2,:);
        ok = ratio <= nnThreshold^2;
        
        numIndex(j) = sum(ok);                
                
    end    
%     fprintf('%d\n', i);

    [~, lbs] = sort(numIndex, 'descend');
    Y(i) = lbs(1:k);
    timeTest(i) = toc;
end

end