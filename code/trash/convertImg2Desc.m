clear all; close all; clc;
type = 1;

switch(type)
    case 1
        name = 'desc_sift_real_gopro';
        real = true;
        path = '/Users/leandrobm/Documents/robohomegopro/';
        
    case 2
        name = 'desc_sift_sim_gopro';
        real = false;
        path = '../../../../Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/';
        
    case 3
        name = 'desc_sift_real_omni';
        real = true;
        
    case 4
        name = 'desc_sift_sim_omni';
        real = false;
end

cont = 1;
numPart = 40;
toSave = false;
if real
    files = dir(sprintf('%s*.JPG', path));
    
    n = size(files,1);
    imgsDescr{numPart} = [];
    labels = zeros(1,numPart);
    timeExt = zeros(1,numPart);
    inds = zeros(1,numPart);
    
    j = 1;
    for i = 1:n
        numClass = str2double(files(i).name(2:3));
        
        if ( mod(i, numPart) == 0)
            k = numPart;
            toSave = true;
        else
            k =  mod(i, numPart);
        end
        
        tic
        img = imread(sprintf('%s%s', path, files(i).name));
        img = single(rgb2gray(img));
        [~, descr] = vl_sift(img);
        timeExt(k) = toc;
        
        imgsDescr{k} = single(descr);
        labels(k) = numClass;
        inds(k) = i;
        
        if (toSave)
            save(sprintf('%s%.2d', name, cont), 'imgsDescr', 'labels', 'inds');
            cont = cont + 1;
            toSave = false;
        end
        
        fprintf('Real - %d\n', i);
    end
    
else
    
end

