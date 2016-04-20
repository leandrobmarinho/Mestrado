clear; close all; clc;

folder = 'omni/'; type = 11;
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
    
    if (type == 1 || type == 2 || type == 14)
        num = size(result.metricasGeralMedia,2);
    end
    
    if (type == 3 || type == 4 || type == 15)
        metricas(1:2:11) = result.metricasGeralMedia;
        metricas(2:2:12) = std(result.metricasGeral,0,1);
    end
    
    if (( (type >= 7 && type <= 13) || type == 17 || type == 18 ) && isfield(result, 'routes'))
        result = result.routes;
    end
    
    
    switch(type)
        case 10
            %% Reject option with std
            num = length(result);
            for j = 0 : num-1
                metrcs(j*2 + 1) = mean(result{j+1}.hit);
                metrcs(j*2 + 2) = std(result{j+1}.hit);
            end
            
            %General
            values(i) = mean(metrcs(1:2:num*2));
            erros(i) = std(metrcs(1:2:num*2));
            fprintf('%s\n', name);
            clear metrcs
            
        case 11
            %% Reject option with std
            num = length(result);
            for j = 0 : num -1
                metrcs(j*2 + 1) = mean(result{j+1}.hitRej);
                metrcs(j*2 + 2) = std(result{j+1}.hitRej);
            end            
            
            %General
            values(i) = mean(metrcs(1:2:num*2));
            erros(i) = std(metrcs(1:2:num*2));
            fprintf('%s\n', name);
            clear metrcs
    end
    
end