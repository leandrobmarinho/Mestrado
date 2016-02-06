clear all; close all; clc;

folder = 'temp/'; type = 15;
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
    
    num = size(result.metricasGeralMedia,2);
    
    for m = 1 : size(result.matConfTeste,3)                
        [metricas(:,:,m), metricasGeral(m,:)] = metricasMatConf(result.matConfTeste(:,:,m));        
    end
    
    
    result.metricasGeralMedia = mean(metricasGeral,1);
    
    result.metricas = metricas;
    result.metricasGeral = metricasGeral;
    
    % Procura a matriz de confusao mais pr?xima da acc m?dia
    acc = metricasGeral(:,end);
    mediaAcc = mean(acc);
    [~, pos] = sort( abs ( mediaAcc - acc) );
    
    result.matConfTesteMedia2 = result.matConfTeste(:,:,pos(1));
    result.stdAcc = std(acc);
    
    clear metricas metricasGeral;
end


