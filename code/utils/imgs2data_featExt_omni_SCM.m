clear; close all; clc;
addpath('../ImageProcessing/LBP/');
addpath('../ImageProcessing/Haralick/');
addpath('../ImageProcessing/Hu_Moments/');
addpath('../ImageProcessing/scm_1_10/');
% addpath('../../../../Dropbox/Mestrado/Feature Extraction Image/mide_v1/')


%% General Configurations
nameOut = 'scm_others_omni_real';

% Haralick Texture
optionsHaralick.dharalick = 3;

% LBP
optionsLBP.vdiv = 1;                  % one vertical divition
optionsLBP.hdiv = 1;                  % one horizontal divition
optionsLBP.semantic = 0;              % classic LBP
optionsLBP.samples  = 8;              % number of neighbor samples
optionsLBP.mappingtype = 'u2';        % uniform LBP


%%

pathFolder = '/Users/leandrobm/Documents/robohomeomni/';
% pathFolder = '/Users/WELL/Documents/Leandro/Omni_real/';

d = dir(pathFolder);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];


%%
k = 1;
% dataLBP = []; dataHu = []; dataHaralick = []; dataMideSobel = [];
% dataMideAver = []; dataMideGrandMorf = []; dataMideLaplacian = [];
% dataMideMedian = [];
dataSCM_l = []; dataSCM_s = []; dataSCM_a = []; dataSCM_g = [];
for i = 1 : length(nameFolds)
    pathFiles = dir(sprintf('%s%s/*.jpg', pathFolder, char(nameFolds(i))));
    
    % Keep the number class
    numClass = strsplit(nameFolds{i}, ' ');
    numClass = str2double(numClass{2});
    
    for j = 1 : length(pathFiles)
        tic
        imageRGB = imread(sprintf('%s%s/%s', pathFolder, nameFolds{i}, pathFiles(j).name));
        imageGray = rgb2gray(imageRGB);
        tempoConv = toc;
        img = imageGray;
        
        
        %% SCM - Average
        fprintf('SCM average - %s\n', pathFiles(j).name);
        tic
        imgF = imfilter(img,fspecial('average',[9 9]),'replicate');
        
        [~,p] = scm(img, imgF);
        timeSCM_a(k) = toc + tempoConv;
        X = struct2array(p);
        dataSCM_a = [dataSCM_a; [X numClass] ];
        
        
        
        
        %% SCM - Gaussian
        fprintf('SCM Gaussian - %s\n', pathFiles(j).name);
        
        tic
        imgF = imfilter(img, fspecial('gaussian',[9 9]),'replicate');
        
        [~,p] = scm(img, imgF);
        timeSCM_g(k) = toc + tempoConv;
        X = struct2array(p);
        dataSCM_g = [dataSCM_g; [X numClass] ];
        
        
        
        %% SCM - Laplacian
        fprintf('SCM laplacian - %s\n', pathFiles(j).name);
        
        tic
        imgF = imfilter(img,fspecial('laplacian'),'replicate');
        
        [~,p] = scm(img, imgF);
        timeSCM_l(k) = toc + tempoConv;
        X = struct2array(p);
        dataSCM_l = [dataSCM_l; [X numClass] ];
        
        
        
        %% SCM - Sobel
        fprintf('SCM sobel - %s\n\n', pathFiles(j).name);
        
        tic
        imgF = imfilter(img,fspecial('sobel'),'replicate');
        
        [~,p] = scm(img, imgF);
        timeSCM_s(k) = toc + tempoConv;
        X = struct2array(p);
        dataSCM_s = [dataSCM_s; [X numClass] ];
        
        

        
        save(nameOut)
        k = k + 1;
    end
end

% clearvars -except dataHaralick dataHu dataLBP timeHaralick ...
%     timeHu timeLBP nameOut
clearvars folder i imageGray imageRGB img imgF numClass p tempoConv X files

save(nameOut)
