clear all; close all; clc;

%% General Configurations
% Haralick Texture
optionsHaralick.dharalick = 3;

% LBP
optionsLBP.vdiv = 1;                  % one vertical divition
optionsLBP.hdiv = 1;                  % one horizontal divition
optionsLBP.semantic = 0;              % classic LBP
optionsLBP.samples  = 8;              % number of neighbor samples
optionsLBP.mappingtype = 'u2';        % uniform LBP


%%
addpath('../LBP/'); addpath('../haralick/'); addpath('../hu_moments/');
addpath('../../../../Dropbox/Mestrado/Feature Extraction Image/mide_v1/')

pathFolder = '../../../../Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/';

d = dir(pathFolder);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';

nameFolds(ismember(nameFolds,{'.','..', 'Capturar frames', 'Cortar imagens'})) = [];


%%
k = 1;
dataLBP = []; dataHu = []; dataHaralick = []; dataMideSobel = [];
dataMideAver = [];
for i = 1 : length(nameFolds)
    pathFiles = dir(sprintf('%s%s/*.png', pathFolder, char(nameFolds(i))));
    
    for j = 1 : length(pathFiles)
        imageRGB = imread(sprintf('%s%s/%s', pathFolder, nameFolds{i}, pathFiles(j).name));
        %         imageHSV = rgb2hsv(imageRGB);
        %         imageHSV = imageHSV(:,:,1);
        imageGray = rgb2gray(imageRGB);
        
        numClass = strsplit(nameFolds{i}, 'C');
        numClass = str2double(numClass{2});
        
        img = imageGray;
        
        %% Mide - Sobel
        fprintf('Mide Sobel - %s\n', pathFiles(j).name);

        tic
        I2 = edge(img, 'sobel');
        
        [M,~] = mide(img, I2);
        stats = mideprops(M, 'all');
        timeMideSobel(k) = toc;
        X = struct2array(stats);
        
        dataMideSobel = [dataMideSobel; [X numClass] ];
        
        
        %% Mide - Average
        fprintf('Mide Average - %s\n', pathFiles(j).name);

        tic
        m = fspecial('average', 15);
        I2 = imfilter(img, m);
        
        [M,~] = mide(img, I2);
        stats = mideprops(M, 'all');
        timeMideAver(k) = toc;
        X = struct2array(stats);
        
        dataMideAver = [dataMideAver; [X numClass] ];
        
        
        
        %% Haralick Texture
        fprintf('Haralick Texture - %s\n', pathFiles(j).name);
        
        tic
        GLCM2 = graycomatrix(img); %graycomatrix(I,'Offset',[2 0;0 2]);
        stats = GLCM_Features1(GLCM2,0);
        timeHaralick(k) = toc;
        X = struct2array(stats);
        
        dataHaralick = [dataHaralick; [X numClass] ];
        
        
        
        %% Local Binary Pattern
        fprintf('Local Binary Pattern - %s\n', pathFiles(j).name);
        tic
        [X, ~] = lbp(img,[],optionsLBP);
        timeLBP(k) = toc;
        dataLBP = [dataLBP; [X numClass] ];
        
        
        
        %% Hu Moments
        fprintf('Hu Moments - %s\n\n', pathFiles(j).name);
        tic
        X = invmoments(img);
        timeHu(k) = toc;
        %     [X,~] = hugeo(imageRGB);
        
        dataHu = [dataHu; [X numClass] ];
        
        save('gray_all_gopro_sim')
        k = k + 1;
    end
end
