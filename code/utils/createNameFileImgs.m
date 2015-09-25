function [ ] = createNameFileImgs( path, type )
%LOADIMGS Summary of this function goes here
%   path - path of the imgs
%   type
%       1: real gopro
%       2: sim gopro
%       3: real gopro
%       4: sim gopro

switch(type)
    case 1
        name = 'nameFile_real_gopro';
        real = true;
        
    case 2
        name = 'nameFile_sim_gopro';
        real = false;
    
    case 3
        name = 'nameFile_real_omni';
        real = true;
        
    case 4
        name = 'nameFile_sim_omni';
        real = false;
end

if real
    files = dir(sprintf('%s*.JPG', path));
    
    n = size(files,1);    
    imgs{n} = [];
    labels = zeros(1,n);
    for i = 1:n
        
%         img = imread(sprintf('%s%s', path, files(i).name));
        numClass = str2double(files(i).name(2:3));
        
%         imgs{i}.img = img;
        imgs{i} = files(i).name;
        labels(i) = numClass;
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

%             img = imread(sprintf('%s%s/%s', path, nameFolds{i}, pathFiles(j).name));
            
            numClass = strsplit(nameFolds{i}, 'C');
            numClass = str2double(numClass{2});
            
%             imgs{k}.img = img;
            imgs{k} = sprintf('%s/%s', nameFolds{i}, pathFiles(j).name);
            labels(k) = numClass;
            
            k = k + 1;
        end
    end
    
end

save(name, 'imgs', 'labels')
end

