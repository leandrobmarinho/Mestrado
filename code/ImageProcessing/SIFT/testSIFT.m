function [Y, timeTest, output] = testSIFT( model, testData, k, nnThreshold )
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

for i = 1 : numTest
    
    % Load only if there is not batch in memory
    indImg = testData.imgs(i);
    indImg = mod(indImg,40);
    if (indImg == 0)
        indImg = 40;
    end
    img = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P%0.2d_%0.2d.JPG', testData.labels(i), indImg)) ;
    img = single(rgb2gray(img));
    
    [~, descrsTest] = vl_sift(img);
    descrsTest = single(descrsTest);
    
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
    
    fprintf('%d \n', i);
    output = [output; lbs];
end

end