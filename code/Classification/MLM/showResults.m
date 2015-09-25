clear all; close all; clc; addpath('../');

folder = 'resultSelec/';
files = dir(sprintf('%s*.mat', folder));

for i = 1 : numel(files)
    load(sprintf('%s%s', folder, files(i).name));
    num = size(r.metricasGeralMedia,2);
    
    
    %     fprintf([repmat('%0.4f\t', 1, num) '\t%s\n'], r.metricasGeralMedia*100,...
    %     files(i).name);
    
    %     fprintf('%0.2f\t%0.2f\t%0.2f\t%0.4f\t%0.6f\t%0.2f\t%s\n', max(r.metricasGeral(:,6))*100, ...
    %         min(r.metricasGeral(:,6))*100, r.metricasGeralMedia(6)*100, r.stdAcc, ...,
    %         r.tempoTreinMedio, mean(r.tempoTeste/2060)*1000000, files(i).name);
    
%         fprintf('& %0.2f\t& %0.2f\t& %0.2f\t& %0.2f\t& %0.6f s\t& %0.2f $\\us$ \\\\\t %s\n', max(r.metricasGeral(:,6))*100, ...
%             min(r.metricasGeral(:,6))*100, r.metricasGeralMedia(6)*100, r.stdAcc*100, ...,
%             r.tempoTreinMedio, mean(r.tempoTeste/2060)*1000000, files(i).name);
    
    r.metricasGeralMedia = r.metricasGeralMedia*100;
    desP = std(r.metricasGeral)*100;
    fprintf('%0.2f/%0.2f\t%0.2f/%0.2f\t%0.2f/%0.2f\t%0.2f/%0.2f\t %s\n', r.metricasGeralMedia(1), ...        
        desP(1), r.metricasGeralMedia(2), desP(2), r.metricasGeralMedia(6), desP(6), r.metricasGeralMedia(5), desP(5), files(i).name);
    
%         fprintf('%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.6f\t%0.2f\t%s\n', max(r.metricasGeral(:,6))*100, ...
%             min(r.metricasGeral(:,6))*100, r.metricasGeralMedia(6)*100, r.stdAcc*100, ...,
%             r.tempoTreinMedio, mean(r.tempoTeste/2060)*1000000, files(i).name);

end