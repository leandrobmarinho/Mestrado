function [ ] = createDescrImgs( path, type )
%LOADIMGS Summary of this function goes here
%   path - path of the imgs
%   type
%       1: real gopro
%       2: sim gopro
%       3: real gopro
%       4: sim gopro

switch(type)
    case 1
        name = 'desc_real_gopro';
        real = true;
        
    case 2
        name = 'desc_sim_gopro';
        real = false;
        
    case 3
        name = 'desc_real_omni';
        real = true;
        
    case 4
        name = 'desc_sim_omni';
        real = false;
end

if real
    files = dir(sprintf('%s*.JPG', path));
    
    n = size(files,1);
    imgsDescr{n} = [];
    labels = zeros(1,n);
    timeExt = zeros(1,n);
    for i = 1:n
        numClass = str2double(files(i).name(2:3));
        
        tic
        img = imread(sprintf('%s%s', path, files(i).name));
        img = single(rgb2gray(img));
        
        [~, descr] = vl_sift(img);
        timeExt(i) = toc;
        imgsDescr{i} = single(descr);
        labels(i) = numClass;
        
        fprintf('Real - %d\n', i);
    end
    
else
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
            img = single(rgb2gray(img));
            
            [~, descr] = vl_sift(img);
            timeExt(k) = toc;
            imgsDescr{k} = single(descr);            
            labels(k) = numClass;
            
            fprintf('Sim - %d\n', k);
            k = k + 1;            
        end
    end
    
end

save(name, 'imgsDescr', 'labels', 'timeExt')
end

