clear; close all; clc;

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
    
    
    for j = 1 : size(result.matConfTeste,3)
        
        matriz_old = result.matConfTeste(:,:,j);
        
        matriz_new = [sum(matriz_old(1:3, :)); sum(matriz_old(4:5, :)); ...
            sum(matriz_old(6:7, :)); sum(matriz_old(8:10, :)); sum(matriz_old([11 15], :)); ...
            sum(matriz_old(12:14, :));];
        
        matriz_new = [sum(matriz_new(:,1:3),2) sum(matriz_new(:,4:5),2) ...
            sum(matriz_new(:, 6:7),2) sum(matriz_new(:, 8:10),2) sum(matriz_new(:, [11 15]),2) ...
            sum(matriz_new(:, 12:14),2)];
        
        
        %% Metricas
        Ntest = sum(matriz_new(:));
        
        confMatTeste(:,:,j) = matriz_new;
        matConfPorc(:,:,j) = (matriz_new./Ntest).*100;
        [metricas(:,:,j), metricasGeral(j,:)] = metricasMatConf(matriz_new);
    end
    
    % Resultado geral
    result.metricasGeralMedia = mean(metricasGeral,1);
    
    result.matConfTeste = confMatTeste;
    result.matConfPorc = matConfPorc;
    result.metricas = metricas;
    result.metricasGeral = metricasGeral;
    
    % Procura a matriz de confus?o mais proxima da acc m?dia
    acc = metricasGeral(:,end);
    mediaAcc = mean(acc);
    [~, pos] = sort( abs ( mediaAcc - acc) );
    
    result.matConfTesteMedia2 = confMatTeste(:,:,pos(1));
    result.stdAcc = std(acc);
    save(sprintf('NODE_%s', name(6:end-4)), 'result', 'config');
end