clear; close all; clc;

folder = 'temp3/';
type = 1;
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


linha = 1;
coluna = 1;

for i = 1 : numel(files)
    name = namesFile{i};
    load(sprintf('%s%s', folder, name));
    fprintf('%s\n', name);
        
    if (isfield(result, 'routes'))
        result = result.routes;
    end
    
    num = length(result);
    metrcs_hit = zeros(1,num);
    metrcs_hirej = zeros(1,num);
    for j = 1 : num
        metrcs_hit(j) = mean(result{j}.hit);
        metrcs_hirej(j) = mean(result{j}.hitRej);
    end
    
    %General
    valuesNormalSCM(linha, coluna) = mean(metrcs_hit);
    valuesRejSCM(linha, coluna) = mean(metrcs_hirej);
    
    errosNormalSCM(linha, coluna) = std(metrcs_hit);
    errosRejSCM(linha, coluna) = std(metrcs_hirej);


    linha = linha + 1;
    if (linha == 5)
        linha = 1;
        coluna = coluna + 1;
    end
end

clearvars -except valuesNormalSCM valuesRejSCM errosNormalSCM errosRejSCM