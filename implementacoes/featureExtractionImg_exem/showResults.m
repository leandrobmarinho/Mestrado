clear all; close all; clc; addpath('../');

folder = 'hsv/';
files = dir(sprintf('%s*.mat', folder));

% Sort by date
namesFile = [files(:).datenum].';
[~,namesFile] = sort(namesFile);
namesFile = {files(namesFile).name};

for i = 1 : numel(files)
    load(sprintf('%s%s', folder, namesFile{i}));
    num = size(result.metricasGeralMedia,2);
    
    
%     fprintf([repmat('%0.4f\t', 1, num) '\n'], result.metricasGeralMedia*100);
    
%     fprintf([repmat('%0.4f\t', 1, num) '%0.4f\t%0.4f\t%s\n'], result.metricasGeralMedia*100, ....
%         mean(result.tempoTrein), 1000000*mean(result.tempoTeste), namesFile{i});
    

    fprintf('%0.4f\t%0.4f\t%s\n', mean(result.tempoTrein), 1000000*mean(result.tempoTeste), namesFile{i});
    
%     fprintf('%0.4f\t%0.4f\n', mean(result.tempoTrein), 1000000*mean(result.tempoTeste));
    

end