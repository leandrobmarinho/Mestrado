clear; close all; clc;
addpath('../ImageProcessing/scm_1_10/');


folder = '/Users/leandrobm/Documents/robohomegopro/';
files = dir(sprintf('%s*.JPG', folder));

%% General Configurations
nameOut = 'scm_others_gopro_real';

%dataSCM = [];
dataSCM_l = []; dataSCM_s = []; dataSCM_a = [];
% timeSCM = zeros(1,600);
timeSCM_l = zeros(1,600); timeSCM_s = zeros(1,600); timeSCM_a = zeros(1,600);
for i = 1:600
    %% Load the image
    tic
    imageRGB = imread(sprintf('%s%s', folder, files(i).name));
    imageGray = rgb2gray(imageRGB);
    tempoConv = toc;
    
    numClass = str2double(files(i).name(2:3));
    img = imageGray;
    
    
    %% SCM
    fprintf('SCM average - %s\n', files(i).name);
    tic
    imgF = imfilter(img,fspecial('average',[3 3]),'replicate');
    
    [~,p] = scm(img, imgF);
    timeSCM_a(i) = toc + tempoConv;
    X = struct2array(p);
    dataSCM_a = [dataSCM_a; [X numClass] ];
    
    %% SCM
    fprintf('SCM laplacian - %s\n', files(i).name);
    
    tic
    imgF = imfilter(img,fspecial('laplacian'),'replicate');
    
    [~,p] = scm(img, imgF);
    timeSCM_l(i) = toc + tempoConv;
    X = struct2array(p);
    dataSCM_l = [dataSCM_l; [X numClass] ];
    
    %% SCM - Sobel
    fprintf('SCM sobel - %s\n\n', files(i).name);
    
    tic
    imgF = imfilter(img,fspecial('sobel'),'replicate');
    
    [~,p] = scm(img, imgF);
    timeSCM_s(i) = toc + tempoConv;
    X = struct2array(p);
    dataSCM_s = [dataSCM_s; [X numClass] ];
    
    
    save(nameOut)
end

clearvars folder i imageGray imageRGB img imgF numClass p tempoConv X files
save(nameOut)