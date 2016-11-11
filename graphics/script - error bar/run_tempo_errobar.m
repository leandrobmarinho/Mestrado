clear; close all; clc;

% valores1 = [47.3	48.5	50.3
% 3.29E+04	3.25E+04	3.26E+04
% 120.8	110.5	106.8
% 90.6	94.4	89.6
% 305.4	339.6	319.7
% 5.80E+03	5.75E+03	5.83E+03
% 5.19E+03	5.33E+03	5.35E+03]';
% 
% valores2 = [65.6	108.8
% 3.26E+04	3.99E+04
% 210.8	942
% 92.8	114.7
% 351.3	403.2
% 6.24E+03	7.13E+03
% 5.40E+03	5.22E+03]';

valores = [47.3	48.5	50.3	65.6	108.8
3.29E+04	3.25E+04	3.26E+04	3.26E+04	3.99E+04
120.8	110.5	106.8	210.8	942
90.6	94.4	89.6	92.8	114.7
305.4	339.6	319.7	351.3	403.2
5.80E+03	5.75E+03	5.83E+03	6.24E+03	7.13E+03
5.19E+03	5.33E+03	5.35E+03	5.40E+03	5.22E+03]';


%%
isTeste = true;

b = bar(valores);
namesAxisX = {'ME', 'MC', 'MU', 'GLCM*', 'LBP*'};
l = {'Bayes', 'MLM (Mah)', 'MLM-NN (Mah)', 'MLM-NN(Euc/Man)', ...
    'MLP', 'LSSVM (RBF)','SVM (RBF)'};



%%
set(gca,'ygrid','on')

% Nome das Legenda

l = legend(b,l,'Location','northoutside','Orientation', 'horizontal');


if isTeste
    ylim([0 1.5E+04])
end
ax = gca;
set(gca,'FontSize',25) %tamanho axis
set(l,'FontSize',20); %tamanho da legenda

% ============ XTickLabel ============
set(gca,'XTickLabel', namesAxisX)


mycolor = [213,62,79
252,141,89
254,224,139
255,255,191
230,245,152
153,213,148
50,136,189]/255;

colormap(mycolor)

if isTeste
    ylabel('Tempo de Classifica\c{c}\~ao($\mu s$)', 'FontSize', 30, 'interpreter','latex')
    
else
    ylabel('Tempo de Treinamento($s$)', 'FontSize', 30, 'interpreter','latex')
end




set(gcf,'units','normalized','outerposition',[0 0 1 1])
set(gca,'LooseInset',get(gca,'TightInset'))