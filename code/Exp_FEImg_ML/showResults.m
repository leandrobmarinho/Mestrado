clear all; close all; clc;

folder = 'temp/';
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
    
%     fprintf([repmat('%0.4f\t', 1, num) '\n'], result.metricasGeralMedia*100);
    
    fprintf([repmat('%0.4f\t', 1, num) '%0.4f\t%0.4f\t%s\n'], result.metricasGeralMedia*100, ....
        mean(result.tempoTrein), 1000000*mean(result.tempoTeste), name);
    

%     fprintf('%0.4f\t%0.4f\t%s\n', mean(result.tempoTrein), 1000000*mean(result.tempoTeste), name);
    
%     fprintf('%0.4f\t%0.4f\n', mean(result.tempoTrein), 1000000*mean(result.tempoTeste));
    

end