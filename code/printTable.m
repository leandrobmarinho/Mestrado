function [  ] = printTable( tipo, tabela1, tabela2, tabela3, tabela4, varargin)
%PRINTTABLE Summary of this function goes here
%   Detailed explanation goes here
%   tipo
%       1 - metricas (metricas, stdMet, mestricasGeral, stdMetGeral)
%       2 - media (matriz)
%       3 - mediaPercentual - (matriz)

if nargin == 0 || nargin > 5
    error('Número de argumentos inválidos');
end


[lin col] = size(tabela1);

% fileID = fopen('exp.txt','w');

head = '\\begin{table}[!hbt] \n';
head = sprintf('%s \\\\centering \n', head);

switch (tipo)
    case 1
        head = sprintf('%s \\\\caption{\\\\it Accuracy (Acc), sensitivity (Se),', head);
        head = sprintf('%s specificity (Sp) and Harmonicmeans (HM) by class for', head);
        head = sprintf('%s database of ... obtained by ... method} \n', head);
        head = sprintf('%s \\\\label{tab::M2C1}\n', head);
        head = sprintf('%s \\\\begin{tabular}{cccccc}\n', head);
        head = sprintf('%s \\\\hline\n', head);
        head = sprintf('%sCLASS & Sp($\\\\%%%%$) & Se($\\\\%%%%$) &', head);
        head = sprintf('%sHM ($\\\\%%%%$) & Acc($\\\\%%%%$) \\\\\\\\ \\\\hline\n', head);
        fprintf(head)
        
        matriz = []; matrizGeral = [];
        for i = 1 : col
            matriz = [matriz tabela1(:,i) tabela2(:,i) ];
            matrizGeral = [matrizGeral tabela3(:,i) tabela4(:,i)];
        end
        
        for i = 1 : lin
            modelo = sprintf([repmat('& %0.3f$\\pm$%0.3f\t', 1, col) '\\\\ \n'], ...
                matriz(i,:)'*100);
            fprintf('%d %s', i, modelo);
        end
        modelo = sprintf([repmat('& %0.3f$\\pm$%0.3f\t', 1, col) '\\\\ \n'], ...
            matrizGeral(1,:)'*100);
        fprintf('Geral %s', modelo);
        
        
    case 2
        head = sprintf('%s \\\\caption{\\\\it Numerical average confusion', head);
        head = sprintf('%s matrix for database of ... obtained by ... method.}\n', head);
        head = sprintf('%s \\\\label{tabMCNumericoM2C1}\n', head);
        head = sprintf('%s {\\\\normalsize\n', head);
        head = sprintf('%s \\\\begin{tabular}{%s}\n', head, repmat('c',1,col+1));
        head = sprintf('%s \\\\hline\n', head);
        fprintf(head);
        
        modelo = sprintf('& %d\t', 1:col);
        modelo = sprintf('CLASS\t%s\\\\\\\\ \\\\hline\n',modelo);
        fprintf(modelo);
        
        for i = 1 : lin
            modelo = sprintf([repmat('&\t%0.2f\t', 1, col) '\\\\ \n'], ...
                tabela1(i,:)');
            fprintf('%d %s', i, modelo);
        end
        
    case 3
        head = sprintf('%s \\\\caption{\\\\it Average percentage confusion', head);
        head = sprintf('%s matrix for database of ... obtained by ... method.', head);
        head = sprintf('%s \\\\label{a}\n', head);
        head = sprintf('%s {\\\\normalsize\n', head);
        head = sprintf('%s \\\\begin{tabular}{%s}\n', head, repmat('c',1,col+1));
        head = sprintf('%s \\\\hline\n', head);
        fprintf(head);
        
        modelo = sprintf('& %d\t', 1:col);
        modelo = sprintf('CLASS\t%s\\\\\\\\ \\\\hline\n',modelo);
        fprintf(modelo);
        
        for i = 1 : lin
            modelo = sprintf([repmat('&\t%0.2f\t', 1, col) '\\\\ \n'], ...
                tabela1(i,:)');
            fprintf('%d %s', i, modelo);
        end
end

footer = '\\hline \n';
footer = sprintf('%s\t \\\\end{tabular}\n', footer);
footer = sprintf('%s \\\\end{table}\n', footer);
fprintf(footer);



% fclose(fileID);
end

