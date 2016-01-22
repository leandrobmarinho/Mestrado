clear all; close all; clc;
addpath('../ImageProcessing/LBP/');
addpath('../ImageProcessing/Haralick/');
addpath('../ImageProcessing/Hu_Moments/');
% addpath('../../../../Dropbox/Mestrado/Feature Extraction Image/mide_v1/')

folder = '/Users/leandrobm/Documents/robohomegopro/';
nameFiles = 'gray_all_gopro_real';

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
dataLBP = []; dataHu = []; dataHaralick = []; dataMideSobel = [];
dataMideAverage = []; dataMideLaplacian = []; dataMideMedian = [];
for i = 1:600
    %% Load the image
    tic
    imageRGB = imread(sprintf('%s%s', folder, files(i).name));    
%     imageHSV = rgb2hsv(imageRGB);
%     imageHSV = imageHSV(:,:,1);    
    imageGray = rgb2gray(imageRGB);
    tempoConv = toc;
    
    numClass = str2double(files(i).name(2:3));
    img = imageGray;
    
    
    

    
    %% Haralick 
    fprintf('Haralick Texture - %s\n', files(i).name);
    
    tic
    GLCM2 = graycomatrix(img); %graycomatrix(I,'Offset',[2 0;0 2]); 
    stats = GLCM_Features1(GLCM2,0);
    timeHaralick(i) = toc + tempoConv;
    X = struct2array(stats);

    dataHaralick = [dataHaralick; [X numClass] ];

    
    %% Local Binary Pattern
    fprintf('Local Binary Pattern - %s\n', files(i).name);
    tic
    [X, ~] = lbp(img,[],optionsLBP);
    timeLBP(i) = toc + tempoConv;
    dataLBP = [dataLBP; [X numClass] ];
    
    %% Hu Moments
    fprintf('Hu Moments - %s\n\n', files(i).name);
    tic
    X = invmoments(img);
    timeHu(i) = toc + tempoConv;
%     [X,~] = hugeo(imageRGB);
    
    dataHu = [dataHu; [X numClass] ];
    
    
    %% Mide Sobel
%     fprintf('Mide Sobel - %s\n', files(i).name);
%     tic
%     I2 = edge(img, 'sobel');
%     
%     [M,~] = mide(img, I2);    
%     stats = mideprops(M, 'all');
%     timeMideSobel(i) = toc + tempoConv;
%     X = struct2array(stats);
%     
%     dataMideSobel = [dataMideSobel; [X numClass] ];
    
    

    %% Mide Average
%     fprintf('Mide Average - %s\n', files(i).name);
% 
%     tic
%     m = fspecial('average', 15);
%     I2 = imfilter(img, m);
%     
%     [M,~] = mide(img, I2);
%     stats = mideprops(M, 'all');
%     timeMideAver(i) = toc + tempoConv;
%     X = struct2array(stats);
%     
%     dataMideAverage = [dataMideAverage; [X numClass] ];
    
    
    
    %% Mide Laplacian
%     fprintf('Mide Laplaciano - %s\n', files(i).name);
% 
%     tic
%     m = [-1, -1, -1; -1,  8, -1; -1, -1, -1];
%     I2 = imfilter(img, m, 'replicate');
%     
%     [M,~] = mide(img, I2);
%     stats = mideprops(M, 'all');
%     timeMideLapl(i) = toc + tempoConv;
%     X = struct2array(stats);
%     
%     dataMideLaplacian = [dataMideLaplacian; [X numClass] ];

    
    
%     %% Mide - Median
%     fprintf('Mide Median - %s\n', files(i).name);
%     
%     tic
%     I2 = medfilt2(img, [45 45]);
%     
%     [M,~] = mide(img, I2);
%     stats = mideprops(M, 'all');
%     timeMideMedian(i) = toc + tempoConv;
%     X = struct2array(stats);
%     
%     dataMideMedian = [dataMideMedian; [X numClass] ];
    save(name_files)
end

% clearvars -except dataMideMedian timeMideMedian
save(name_files)