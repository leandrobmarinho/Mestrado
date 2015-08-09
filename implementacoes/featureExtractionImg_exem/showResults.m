clear all; close all; clc; addpath('../');

folder = 'rgb/';
files = dir(sprintf('%s*.mat', folder));

for i = 1 : numel(files)
    load(sprintf('%s%s', folder, files(i).name));
    num = size(result.metricasGeralMedia,2);
    
    
    fprintf([repmat('%0.4f\t', 1, num) '\n'], result.metricasGeralMedia*100);
    
%     fprintf([repmat('%0.4f\t', 1, num) '%s\n'], result.metricasGeralMedia*100, files(i).name);

end