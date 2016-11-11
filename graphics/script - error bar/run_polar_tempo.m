clear; close all; clc;

valores = [3.29E+04	3.25E+04	3.26E+04
    47.3	48.5	50.3
120.8	110.5	106.8
90.6	94.4	89.6
305.4	339.6	319.7
5.80E+03	5.75E+03	5.83E+03
5.19E+03	5.33E+03	5.35E+03];
valores = valores;
cores = {'.k', '.m', '.c', '.r', '.b'};

theta = 0:((pi/6)+(pi/2)):4*pi/3;

for i = 1:size(valores,1)
    rho = valores(i,:);
    p = polar(theta,rho, cores{i});
    p.MarkerSize = 50;
    p.LineWidth = 1;
    hold on
end
hold off


l = {'ME', 'MC', 'MU'};
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

set(gca,'LooseInset',get(gca,'TightInset'))
set(gcf,'units','normalized','outerposition',[0 0 1 1])