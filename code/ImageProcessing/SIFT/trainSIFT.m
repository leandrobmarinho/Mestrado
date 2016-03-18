function [model] = trainSIFT( trainData, pathData)
%TRAINSIFT Train of SIFT.
% trainData - data train
% k - number of image model by classes
% pathDescrp - path to load data

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

inds = 0;
for i = 1 : numTrain
    
<<<<<<< HEAD
    % Load only if there is not batch in memory
    indImg = trainData.imgs(i);
    if ( sum(inds == indImg) )
        model.imgs{i} = batchDesc{inds == indImg};
    else
        [batchDesc, inds] = loadDescs(trainData.imgs(i), pathData);
        model.imgs{i} = batchDesc{inds == indImg};
=======
    % Only for route
    for i = 1 : numTrain
        
        indImg = trainData.imgs(i);
        indImg = mod(indImg,40);
        if (indImg == 0)
            indImg = 40;
        end
%         img = imread(sprintf('/Users/leandrobm/Documents/robohomegopro/P%0.2d_%0.2d.JPG', trainData.labels(i), indImg)) ;
        img = imread(sprintf('/Users/WELL/Documents/Leandro/Omni_real/P%0.2d_%0.2d.jpg', trainData.labels(i), indImg)) ;
        img = single(rgb2gray(img));
        
        [~, descrsTrain] = vl_sift(img);
        model.imgs{i} = single(descrsTrain);
>>>>>>> origin/master
    end
    fprintf('Treino SIFT. Arquivo %d de %d\n', i, numTrain);
end
model.labels = trainData.labels;


end