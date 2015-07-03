clear all; close all; clc; addpath('../');

folder = 'resultados/iris/';
files = dir(sprintf('%s*.mat', folder));

for i = 1 : numel(files)
    load(sprintf('%s%s', folder, files(i).name));
    
    fprintf('& %0.2f & %0.2f & %d %s\n', 100*mediaAcc, 100*desvPadr, ceil(mean(numSV)), files(i).name)
    

end