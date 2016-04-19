clear; close all; clc;
addpath('../ImageProcessing/LBP/');
addpath('../ImageProcessing/Haralick/');
addpath('../ImageProcessing/Hu_Moments/');
% addpath('../../../../Dropbox/Mestrado/Feature Extraction Image/mide_v1/')


%% General Configurations
nameOut = 'all_omni_sim';

% Haralick Texture
optionsHaralick.dharalick = 3;

% LBP
optionsLBP.vdiv = 1;                  % one vertical divition
optionsLBP.hdiv = 1;                  % one horizontal divition
optionsLBP.semantic = 0;              % classic LBP
optionsLBP.samples  = 8;              % number of neighbor samples
optionsLBP.mappingtype = 'u2';        % uniform LBP


%%

pathFolder = '/Users/leandrobm/Dropbox/Omni_virtual/';
% pathFolder = '/Users/WELL/Documents/Leandro/Omni_virtual';

d = dir(pathFolder);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

inds = randperm(40);
inds = inds(1:10);

%%
k = 1;
dataLBP = []; dataHu = []; dataHaralick = []; dataMideSobel = [];
% dataMideAver = []; dataMideGrandMorf = []; dataMideLaplacian = [];
% dataMideMedian = [];
for i = 1 : length(nameFolds)
    pathFiles = dir(sprintf('%s%s/*.jpg', pathFolder, char(nameFolds(i))));
    
    % Keep the number class
    numClass = strsplit(nameFolds{i}, ' ');
    numClass = str2double(numClass{2});
    
    for j = inds%1 : length(pathFiles)
        tic
        imageRGB = imread(sprintf('%s%s/%s', pathFolder, nameFolds{i}, pathFiles(j).name));
%         imageHSV = rgb2hsv(imageRGB);
%         imageHSV = imageHSV(:,:,1);
        imageGray = rgb2gray(imageRGB);
        tempoConv = toc;
        img = imageGray;

        
        
        %% ============== Haralick Texture ============== 
        fprintf('Haralick Texture \t- %s\n', pathFiles(j).name);
        
        tic
        GLCM2 = graycomatrix(img); %graycomatrix(I,'Offset',[2 0;0 2]);
        stats = GLCM_Features1(GLCM2,0);
        timeHaralick(k) = toc + tempoConv;
        X = struct2array(stats);
        
        dataHaralick = [dataHaralick; [X numClass] ];
        
        
        
        %% ============== Local Binary Pattern ============== 
        fprintf('Local Binary Pattern \t- %s\n', pathFiles(j).name);
        tic
        [X, ~] = lbp(img,[],optionsLBP);
        timeLBP(k) = toc + tempoConv;
        dataLBP = [dataLBP; [X numClass] ];
        
        
        
        %% ============== Hu Moments ============== 
        fprintf('Hu Moments \t- %s\n\n', pathFiles(j).name);
        tic
        X = invmoments(img);
        timeHu(k) = toc + tempoConv;
        %     [X,~] = hugeo(imageRGB);
        
        dataHu = [dataHu; [X numClass] ];
        
        save(nameOut)
        k = k + 1;
    end
end

clearvars -except dataHaralick dataHu dataLBP timeHaralick ...
    timeHu timeLBP nameOut
save(nameOut)
