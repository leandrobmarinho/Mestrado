function [Y, timeTest, output] = testSIFT( model, testData, k, nnThreshold, type)
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

if (strcmp(type, 'real_gopro'))
    limite = 40;
    comando_leitura = 'img = imread(sprintf(''/Users/leandrobm/Documents/robohomegopro/P%02d_%02d.JPG'', testData.labels(i), indImg));';
    
elseif (strcmp(type, 'real_omni'))
    limite = 50;
    comando_leitura = 'img = imread(sprintf(''/Users/leandrobm/Documents/robohomeomni/classe %02d/Omn%02d_%02d.jpg'', testData.labels(i), testData.labels(i), indImg));';
end

for i = 1 : numTest
    
    % Load only if there is not batch in memory
    indImg = testData.imgs(i);
    indImg = mod(indImg, limite);
    if (indImg == 0)
        indImg = limite;
    end
<<<<<<< HEAD
    eval(comando_leitura);
=======
%     img = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P%0.2d_%0.2d.JPG', testData.labels(i), indImg)) ;
    img = imread(sprintf('/Users/WELL/Documents/Leandro/Omni_real/P%0.2d_%0.2d.JPG', testData.labels(i), indImg)) ;
    
>>>>>>> origin/master
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