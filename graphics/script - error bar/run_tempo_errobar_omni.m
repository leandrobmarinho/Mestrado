clear; close all; clc;


valores = [5.95E+01	7.54E+01	3.64E+01	1.58E+02	2.91E+02
3.43E+02	3.20E+02	3.74E+02	2.97E+02	3.32E+02
3.43E+04	6.39E+04	3.53E+04	3.45E+04	3.53E+04
1.66E+02	1.20E+02	1.60E+02	2.75E+02	1.21E+03
2.91E+02	3.79E+02	2.92E+02	3.04E+02	9.17E+02
8.28E+01	9.72E+01	8.71E+01	8.77E+01	9.83E+01]';


%%
isTeste = true;

b = bar(valores);
namesAxisX = {'ME', 'MC*', 'MU', 'GLCM', 'LBP'};
l = {'Bayes', 'LSSVM (RBF)' 'MLM (Mah/Euc)', 'MLM-NN (Mah/Euc)', ...
    'MLP', 'SVM (RBF)'};



%%
set(gca,'ygrid','on')

% Nome das Legenda

l = legend(b,l,'Location','northoutside','Orientation', 'horizontal');


if isTeste
    ylim([0 1.5E+03])
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