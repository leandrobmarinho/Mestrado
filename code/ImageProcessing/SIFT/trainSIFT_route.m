function [model] = trainSIFT_route( trainData, type)
%TRAINSIFT Train of SIFT.
% trainData - data train
% k - number of image model by classes
% pathDescrp - path to load data

numTrain = length(trainData.labels);

if (strcmp(type, 'real_gopro'))
    limite = 40;
    comando_leitura = 'img = imread(sprintf(''/Users/leandrobm/Documents/robohomegopro/P%02d_%02d.JPG'', trainData.labels(i), indImg));';
    
elseif (strcmp(type, 'real_omni'))
    limite = 50;
    comando_leitura = 'img = imread(sprintf(''/Users/leandrobm/Documents/robohomeomni/classe %02d/Omn%02d_%02d.jpg'', trainData.labels(i), trainData.labels(i), indImg));';
end

% Only for route
for i = 1 : numTrain
    
    indImg = trainData.imgs(i);
    indImg = mod(indImg,limite);
    if (indImg == 0)
        indImg = limite;
    end
    eval(comando_leitura);
    img = single(rgb2gray(img));
    
    [~, descrsTrain] = vl_sift(img);
    model.imgs{i} = single(descrsTrain);
end
model.labels = trainData.labels;
end