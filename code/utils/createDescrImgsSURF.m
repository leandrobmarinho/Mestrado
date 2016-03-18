clear; close all; clc;
type = 3;

switch(type)
    case 1
        name = 'desc_surf_real_gopro';
        real = true;
        in = '/Users/leandrobm/Documents/robohomegopro/';
        
    case 2
        name = 'desc_surf_sim_gopro';
        real = false;
        in = '../../../../Dropbox/2015_InTech_Mapa_Topologico/Simulation V-REP/Imagens/';
        
        %     case 3
        % %         name = 'desc_surf_real_omni';
        %         path = '/Users/leandrobm/Documents/robohomeomni/';
        %         real = true;
        %
        %     case 4
        %         name = 'desc_surf_sim_omni';
        %         real = false;
        
    case 3
        name = 'desc_surf_real_omni';
        real = true;
        in = '/Users/WELL/Documents/Leandro/Omni_real/';
        output = '/Users/WELL/Documents/Leandro/data/SURF_real_omni/';
        
    case 4
        name = 'desc_surf_sim_omni';
        in = '/Users/WELL/Documents/Leandro/Omni_virtual/';
        real = false;
        output = '/Users/WELL/Documents/Leandro/data/SURF_sim_omni/';
end

if type == 1
    files = dir(sprintf('%s*.JPG', in));
    
    n = size(files,1);
    imgsFrames{n} = [];
    labels = zeros(1,n);
    timeExt = zeros(1,n);
    for i = 1:n
        numClass = str2double(files(i).name(2:3));
        
        tic
        img = imread(sprintf('%s%s', in, files(i).name));
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
    d = dir(in);
    isub = [d(:).isdir];
    nameFolds = {d(isub).name}';
    
    nameFolds(regexpcell(nameFolds, 'P*', true)) = [];
    
    k = 1;
    for i = 1 : length(nameFolds)
        pathFiles = dir(sprintf('%s%s/*.png', in, char(nameFolds(i))));
        
        for j = 1 : length(pathFiles)
            numClass = strsplit(nameFolds{i}, 'C');
            numClass = str2double(numClass{2});
            
            tic
            img = imread(sprintf('%s%s/%s', in, nameFolds{i}, pathFiles(j).name));
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
    
elseif type == 3 || type == 4 % Real and Sim Omni
    k = 1;
    cont = 1;
    
    d = dir(in);
    isub = [d(:).isdir]; %# returns logical vector
    nameFolds = {d(isub).name}';
    nameFolds(ismember(nameFolds,{'.','..'})) = [];
    
    for i = 1 : length(nameFolds)
        pathFiles = dir(sprintf('%s%s/*.jpg', in, char(nameFolds(i))));
        
        % Keep the number class
        numClass = strsplit(nameFolds{i}, ' ');
        numClass = str2double(numClass{2});
        
        for j = 1 : length(pathFiles)
            
            tic
            img = imread(sprintf('%s%s/%s', in, nameFolds{i}, pathFiles(j).name));
            img = rgb2gray(img);
            
            points = detectSURFFeatures(img);
            [frames, ~] = extractFeatures(img, points);
            
            timeExt(k) = toc;
            imgsFrames{k} = frames;
            labels(k) = numClass;
            
            fprintf('%s Omni - %d %d\n', name, i, j);
            if (k == 150)
                k = 0;
                save(sprintf('%s%s_%.2d', output, name, cont), 'imgsFrames', 'labels', 'timeExt')
                cont = cont + 1;
            end
            
            k = k + 1;
        end
    end
end

% save(name, 'imgsFrames', 'labels', 'timeExt')