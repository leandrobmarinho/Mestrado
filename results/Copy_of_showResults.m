clear; close all; clc;

folder = 'omni/Route/';
type = 16;
precisao = 2;
files = dir(sprintf('%s*.mat', folder));

% Sort by date
% dateFile = [files(:).datenum]';
% [~,indexFile] = sort(dateFile);
% namesFile = {files(indexFile).name};

% Sort by name
name = {files.name};
[~, index] = sort(name);
namesFile = name(index);


for i = 1 : numel(files)
    name = namesFile{i};
    load(sprintf('%s%s', folder, name));
                    
    if (not(isempty(strfind(name, 'mlm'))))
        fprintf('$K=%d%%$\t %s\n', config.k*100 ,name)
        
    elseif (not(isempty(strfind(name, 'mlp'))))
%         fprintf('$CO=%d$\t %s\n', optParam,name)
        
    elseif (not(isempty(strfind(name, 'linear'))))
%         fprintf('$C=%d$\t %s\n', config.paraC, name)
        
    elseif (not(isempty(strfind(name, 'rbf'))))        
%         fprintf('$C=%d;\\sigma=%d$\t %s\n', config.paraC, config.sigma ,name)
        
    end
    
    
end