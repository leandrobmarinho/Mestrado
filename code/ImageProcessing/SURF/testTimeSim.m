clear all; close all; clc;
p = path; path(p, '../');



% Train
tic

imgsTrain{1} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P3_C1/s (3).png') ;
imgsTrain{2} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P3_C2/s (10).png') ;
imgsTrain{3} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P3_C3/s (20).png');
imgsTrain{4} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P4_C4/s (32).png');
imgsTrain{5} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P4_C5/s (200).png');
imgsTrain{6} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P2_C6/s (5).png');
imgsTrain{7} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P2_C7/s (53).png') ;
imgsTrain{8} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P1_C8/s (93).png') ;
imgsTrain{9} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P1_C9/s (13).png');
imgsTrain{10} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P1_C10/s (38).png');
imgsTrain{11} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P5_C11/s (89).png');
imgsTrain{12} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P6_C12/s (52).png');
imgsTrain{13} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P6_C13/s (1).png') ;
imgsTrain{14} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P6_C14/s (74).png') ;
imgsTrain{15} = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P5_C15/s (32).png');


for i = 1 : length(imgsTrain)
    
    points = detectSURFFeatures(rgb2gray(imgsTrain{i}));
    [framesTrain{i}, ~] = extractFeatures(rgb2gray(imgsTrain{i}), points);
        
end
timeTrain = toc;

fprintf('Test\n');
% Test
tic
imT = imread('/Users/leandrobm/Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/P3_C1/s (32).png') ;
points = detectSURFFeatures(rgb2gray(imT));
[frameT, ~] = extractFeatures(rgb2gray(imT), points);

for i = 1 : 15
    
    indexPairs = matchFeatures(frameT, framesTrain{i});
        
    numIndex(i) = size(indexPairs,1);
end

[~, lbs] = sort(numIndex, 'descend');
lbs(1)

timeTest = toc;



path(p);