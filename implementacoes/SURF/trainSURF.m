function [model] = trainSURF( trainData, pathData )
%TRAINSURF Train of SURF. 
% trainData - data train

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
    
%     model.imgs{i} = loadDescs(trainData.imgs(i));

    % Load only if there is not batch in memory
    indImg = trainData.imgs(i);
    if ( sum(inds == indImg) )
        model.imgs{i} = batchDesc{inds == indImg};
    else
        [batchDesc, inds] = loadDescs(trainData.imgs(i), pathData);
        model.imgs{i} = batchDesc{inds == indImg};
    end
end
model.labels = trainData.labels;

end