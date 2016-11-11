clear; close all; clc;
addpath('../ImageProcessing/scm_1_10/');


folder = '/Users/leandrobm/Documents/robohomegopro/';
files = dir(sprintf('%s*.JPG', folder));

%% General Configurations
nameOut = 'scm_gopro_real';

dataSCM = [];
timeSCM = zeros(1,600);
for i = 1:600
    %% Load the image
    tic
    imageRGB = imread(sprintf('%s%s', folder, files(i).name));    
    imageGray = rgb2gray(imageRGB);
    tempoConv = toc;
    
    numClass = str2double(files(i).name(2:3));
    img = imageGray;
    
    
    %% SCM 
    fprintf('SCM - %s\n', files(i).name);
    
    tic
    imgF = imfilter(img,fspecial('Gaussian',[3 3],0.5),'replicate');
    [~,p] = scm(img, imgF);
    timeSCM(i) = toc + tempoConv;
    X = struct2array(p);
    dataSCM = [dataSCM; [X numClass] ];

    save(nameOut)
end

clearvars -except nameOut dataSCM timeSCM
save(nameOut)