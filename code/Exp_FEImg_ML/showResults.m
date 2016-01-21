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

modelStr = '%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.3f$\\pm$%0.2f\t%0.3f$\\pm$%0.2f\t%s\n';
modelStr2 = '%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%s\n';
for i = 1 : numel(files)
    name = namesFile{i};
    load(sprintf('%s%s', folder, name));
    
    if (type == 1 || type == 2 || type == 14)
        num = size(result.metricasGeralMedia,2);
    end
    
    if (type == 3 || type == 4)
        metricas(1:2:11) = result.metricasGeralMedia;
        metricas(2:2:12) = std(result.metricasGeral,0,1);
    end
    
    if (type >= 7 && type <= 13 && isfield(result, 'routes'))
        result = result.routes;
    end
    
    
    switch(type)
        case 1
            fprintf([repmat('%0.4f\t', 1, num) '\n'], result.metricasGeralMedia*100);
            
        case 2
            fprintf([repmat('%0.4f\t', 1, num) '%0.4f\t%0.4f\t%s\n'], result.metricasGeralMedia*100, mean(result.tempoTrein), 1000000*mean(result.tempoTeste), name);
            
        case 3
            fprintf(modelStr, metricas*100,mean(result.tempoTrein), std(result.tempoTrein), 1000000*mean(result.tempoTeste), 1000000*std(result.tempoTeste), name);
            
        case 4
            fprintf(modelStr2, metricas*100, name);
            
        case 5
            fprintf('%0.4f\t%0.4f\t%s\n', mean(result.tempoTrein), 1000000*mean(result.tempoTeste), name);
            
        case 6
            fprintf('%0.4f\t%0.4f\n', mean(result.tempoTrein), 1000000*mean(result.tempoTeste));
            
            
        case 7
            %% Only route
            num = length(result);
            for j = 1 : num
                metrcs(j) = mean(result{j}.hit);
            end
            
            %General
            metrcs(num + 1) = mean(metrcs);
            fprintf([repmat('%0.2f\t', 1, num+1) '%s\n'], 100*metrcs, name)
            clear metrcs
            
            
        case 8
            %% Only route with std
            num = length(result);
            for j = 0 : num -1
                metrcs(j*2 + 1) = mean(result{j+1}.hit);
                metrcs(j*2 + 2) = std(result{j+1}.hit);
            end
            
            %General
            metrcs(num*2 + 1) = mean(metrcs(1:2:num*2));
            metrcs(num*2 + 2) = std(metrcs(1:2:num*2));
            fprintf([repmat('%0.2f$\\pm$%0.2f\t', 1, num+1) '%s\n'], 100*metrcs, name)
            clear metrcs
            
            
        case 9
            %% Only reject option
            num = length(result);
            for j = 1 : num
                metrcs(j) = mean(result{j}.hitRej);
            end
            
            %General
            metrcs(num + 1) = mean(metrcs);
            fprintf([repmat('%0.2f\t', 1, num+1) '%s\n'], 100*metrcs, name)
            clear metrcs
            
            
        case 10
            %% Only reject option with std
            num = length(result);
            for j = 0 : num -1
                metrcs(j*2 + 1) = mean(result{j+1}.hitRej);
                metrcs(j*2 + 2) = std(result{j+1}.hitRej);
            end
            
            %General
            metrcs(num*2 + 1) = mean(metrcs(1:2:num*2));
            metrcs(num*2 + 2) = std(metrcs(1:2:num*2));
            fprintf([repmat('%0.2f$\\pm$%0.2f\t', 1, num+1) '%s\n'], 100*metrcs, name)
            clear metrcs
            
            
        case 11
            %% Route with rejec option
            num = length(result);
            for j = 0 : num -1
                metrcs(j*2 + 1) = mean(result{j+1}.hit);
                metrcs(j*2 + 2) = mean(result{j+1}.hitRej);
            end
            
            %General
            metrcs(num*2 + 1) = mean(metrcs(1:2:num*2));
            metrcs(num*2 + 2) = mean(metrcs(2:2:num*2));
            fprintf([repmat('%0.2f/%0.2f\t', 1, num+1) '%s\n'], 100*metrcs, name)
            clear metrcs
            
        case 12
            %% Only route with std (II)
            num = length(result);
            for j = 0 : num -1
                metrcs(j*2 + 1) = mean(result{j+1}.hit);
                metrcs(j*2 + 2) = std(result{j+1}.hit);
            end
            
            %General
            metrcs(num*2 + 1) = mean(metrcs(1:2:num*2));
            metrcs(num*2 + 2) = std(metrcs(1:2:num*2));
            
            
            fprintf(repmat('%0.2f$\\pm$%0.2f\t', 1, num), 100*metrcs(1:num) )
            fprintf('\n')
            fprintf(repmat('%0.2f$\\pm$%0.2f\t', 1, num), 100*metrcs(num+1:num*2))
            fprintf('%0.2f$\\pm$%0.2f\t%s\n', 100*metrcs(num*2+1), 100*metrcs(num*2+2), name)
%             fprintf('$\\textbf{General result:}$ %0.2f$\\pm$%0.2f\n', 100*metrcs(num*2+1), 100*metrcs(num*2+2))
%             keyboard

            clear metrcs
            
        case 13
            %% Only reject option with std (II)
            num = length(result);
            for j = 0 : num -1
                metrcs(j*2 + 1) = mean(result{j+1}.hitRej);
                metrcs(j*2 + 2) = std(result{j+1}.hitRej);
            end
            
            %General
            metrcs(num*2 + 1) = mean(metrcs(1:2:num*2));
            metrcs(num*2 + 2) = std(metrcs(1:2:num*2));
            
            
            fprintf(repmat('%0.2f$\\pm$%0.2f\t', 1, num), 100*metrcs(1:num) )
            fprintf('\n')
            fprintf(repmat('%0.2f$\\pm$%0.2f\t', 1, num), 100*metrcs(num+1:num*2))
            fprintf('%0.2f$\\pm$%0.2f\t%s\n', 100*metrcs(num*2+1), 100*metrcs(num*2+2), name)
%             fprintf('$\\textbf{General result:}$ %0.2f$\\pm$%0.2f\n', 100*metrcs(num*2+1), 100*metrcs(num*2+2))
%             keyboard

            clear metrcs

            
        case 14
            fprintf(' %s \n', name)
            fprintf([repmat('%0.2f\t', 1, num) '\n'], mean(result.metricas, 3)*100);
            fprintf([repmat('%0.2f\t', 1, num) '\n'], result.metricasGeralMedia*100);
            
        case 15
%             fprintf('%0.2f$\\pm$%0.2f\t0.01$\\pm$0.01\t%0.2f$\\pm$%0.2f\t%s\n', result.metricasGeralMedia(end)*100, std(result.metricasGeral(:, end)*100), 1000000*mean(result.tempoTeste), 1000000*std(result.tempoTeste), name);

            
    end
    
end