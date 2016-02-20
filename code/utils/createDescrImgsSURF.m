clear all; close all; clc;
type = 3;

switch(type)
    case 1
        name = 'desc_surf_real_gopro';
        real = true;
        path = '/Users/leandrobm/Documents/robohomegopro/';
        
    case 2
        name = 'desc_surf_sim_gopro';
        real = false;
        path = '../../../../Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/';
        
    case 3
%         name = 'desc_surf_real_omni';
        path = '/Users/leandrobm/Documents/robohomeomni/';
        real = true;
        
    case 4
        name = 'desc_surf_sim_omni';
        real = false;
end

if type == 1
    files = dir(sprintf('%s*.JPG', path));
    
    n = size(files,1);
    imgsFrames{n} = [];
    labels = zeros(1,n);
    timeExt = zeros(1,n);
    for i = 1:n
        numClass = str2double(files(i).name(2:3));
        
        tic
        img = imread(sprintf('%s%s', path, files(i).name));
        img = rgb2gray(img);
        
        points = detectSURFFeatures(img);
        [frames, ~] = extractFeatures(img, points);
        
        timeExt(i) = toc;
        imgsFrames{i} = frames;
        labels(i) = numClass;
        
        fprintf('Real - %d\n', i);
    end
    
elseif type == 2
    % Sim
    d = dir(path);
    isub = [d(:).isdir];
    nameFolds = {d(isub).name}';
    
    nameFolds(regexpcell(nameFolds, 'P*', true)) = [];
    
    k = 1;
    for i = 1 : length(nameFolds)
        pathFiles = dir(sprintf('%s%s/*.png', path, char(nameFolds(i))));
        
        for j = 1 : length(pathFiles)
            numClass = strsplit(nameFolds{i}, 'C');
            numClass = str2double(numClass{2});
            
            tic
            img = imread(sprintf('%s%s/%s', path, nameFolds{i}, pathFiles(j).name));
            img = rgb2gray(img);
            
            points = detectSURFFeatures(img);
            [frames, ~] = extractFeatures(img, points);
            
            timeExt(k) = toc;
            imgsFrames{k} = frames;
            labels(k) = numClass;
            
            fprintf('Sim - %d\n', k);
            k = k + 1;
        end
    end
    
elseif type == 3 % Omni Real
    k = 1;
    cont = 1;
    
    d = dir(path);
    isub = [d(:).isdir]; %# returns logical vector
    nameFolds = {d(isub).name}';
    nameFolds(ismember(nameFolds,{'.','..'})) = [];
    
    for i = 1 : length(nameFolds)
        pathFiles = dir(sprintf('%s%s/*.jpg', path, char(nameFolds(i))));
        
        % Keep the number class
        numClass = strsplit(nameFolds{i}, ' ');
        numClass = str2double(numClass{2});
        
        for j = 1 : length(pathFiles)
            
            tic
            img = imread(sprintf('%s%s/%s', path, nameFolds{i}, pathFiles(j).name));
            img = rgb2gray(img);
            
            points = detectSURFFeatures(img);
            [frames, ~] = extractFeatures(img, points);
            
            timeExt(k) = toc;
            imgsFrames{k} = frames;
            labels(k) = numClass;
            
            fprintf('Real Omni - %d %d\n', i, j);
            if (k == 150)
                k = 1;
                save(sprintf('/Users/leandrobm/Documents/dados/SURF_real_omni/desc_surf_real_omni_%.2d', cont), 'imgsFrames', 'labels', 'timeExt')
                cont = cont + 1;
            end
            
            k = k + 1;
        end
    end
end

% save(name, 'imgsFrames', 'labels', 'timeExt')


