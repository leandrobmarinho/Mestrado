clear; close all; clc;

valores = [96.47	91.4	87.47	71.47	90.6
36.6	34.53	41.2	50.87	74.33
91.6	93.2	85.67	86.07	95.27
83.93	86.07	74.8	80.47	94.2
91.07	94.8	89.73	85.13	95.07
94.27	94.27	90.4	91.73	96.67
83.87	86.27	74.87	80.6	94.2
91.07	94.8	89.73	85.13	95.07
94.27	94.27	90.4	91.73	96.67
82.47	88.4	83.6	82.93	93.87
72.07	73.73	55.6	72.2	91.33
90.13	92.07	85.13	85.47	94.53]';
valores = valores./100;
cores = {'.k', '.m', '.c', '.r', '.b'};

theta = 0:pi/6:(11/6*pi);

for i = 1:size(valores,1)
    rho = valores(i,:);
    p = polar(theta,rho, cores{i});
    p.MarkerSize = 50;
    p.LineWidth = 1;
    
    hold on
end
hold off


l = {'ME', 'MC', 'MU','GLCM', 'LBP'};
l = legend(l,'Location','northoutside', 'Orientation', 'horizontal');
set(l,'FontSize',20);

namesAxisX = {'ME', 'MC', 'MU', 'GLCM', 'LBP'};
set(gca,'XTickLabel', namesAxisX)



h = findall(gca,'type','text');
cl_names = {'Bayes', 'MLM-NN (Man)', 'SVM (RBF)', 'MLM (Mah)', ...
    'SVM (Lin)', 'MLM (Euc)', 'MLP', 'MLM (Man)', 'MLM-NN (Mah)' ...
    'LSSVM (RBF)', 'MLM-NN (Euc)', 'LSSVM (Lin)'};

for i = 1:size(cl_names,2)
    if i == 2
        h(i).String = sprintf('\n\n%s    ', cl_names{i});
    else
        h(i).String = sprintf('  %s', cl_names{i});
    end
    h(i).FontSize = 18;
end

for i = 13:17
    h(i).FontSize = 16;
end

set(gca,'LooseInset',get(gca,'TightInset'))
set(gcf,'units','normalized','outerposition',[0 0 1 1])