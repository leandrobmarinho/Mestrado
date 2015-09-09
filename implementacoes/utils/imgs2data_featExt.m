clear all; close all; clc;
addpath('../LBP/'); addpath('../haralick/'); addpath('../hu_moments/');
addpath('../../../../Dropbox/Mestrado/Feature Extraction Image/mide_v1/')

folder = '/Users/leandrobm/Documents/robohomegopro/';
files = dir(sprintf('%s*.JPG', folder));

%% General Configurations
% Haralick Texture
optionsHaralick.dharalick = 3;

% LBP
optionsLBP.vdiv = 1;                  % one vertical divition
optionsLBP.hdiv = 1;                  % one horizontal divition
optionsLBP.semantic = 0;              % classic LBP
optionsLBP.samples  = 8;              % number of neighbor samples
optionsLBP.mappingtype = 'u2';        % uniform LBP

% Hu Moments

i = 1;
dataLBP = []; dataHu = []; dataHaralick = []; dataMide = [];
for i = 1:600
    %% Load the image
    imageRGB = imread(sprintf('%s%s', folder, files(i).name));    
%     imageHSV = rgb2hsv(imageRGB);
%     imageHSV = imageHSV(:,:,1);    
    imageGray = rgb2gray(imageRGB);
    
    numClass = str2double(files(i).name(2:3));
    img = imageGray;
    
    %% Mide
    tic
    I2 = edge(img, 'sobel');
    
    [M,~] = mide(img, I2);    
    stats = mideprops(M, 'all');
    timeMide(i) = toc;
    X = struct2array(stats);
    
    dataMide = [dataMide; [X numClass] ];
    
    
    %% Haralick Texture
    fprintf('Haralick Texture - %s\n', files(i).name);
    
    tic
    GLCM2 = graycomatrix(img); %graycomatrix(I,'Offset',[2 0;0 2]); 
    stats = GLCM_Features1(GLCM2,0);
    timeHaralick(i) = toc;
    X = struct2array(stats);

    dataHaralick = [dataHaralick; [X numClass] ];

    
    %% Local Binary Pattern
    fprintf('Local Binary Pattern - %s\n', files(i).name);
    tic
    [X, ~] = lbp(img,[],optionsLBP);
    timeLBP(i) = toc;
    dataLBP = [dataLBP; [X numClass] ];
    
    %% Hu Moments
    fprintf('Hu Moments - %s\n\n', files(i).name);
    tic
    X = invmoments(img);
    timeHu(i) = toc;
%     [X,~] = hugeo(imageRGB);
    
    dataHu = [dataHu; [X numClass] ];
    
    save('result_simulado')
end
