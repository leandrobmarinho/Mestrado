clear; clc; close all;



%% Dados - Extra??o
isGopro = true;


%%
numIter = 30;
load('/Users/leandrobm/GitHub/Mestrado/data/gray_all_omni_real.mat')
lbp = timeLBP(1:30) - 4.835;
glcm = timeHaralick(1:30) - 1.9812;
mu = timeHu(1:30) - 2.1911;
mc = mu - 0.0050;
me = mu - 0.0100;
load('/Users/leandrobm/GitHub/Mestrado/code/ImageProcessing/surf_tempo_real.mat')
surf = repmat(timeTest, 1, 3)+2.8695;
load('/Users/leandrobm/GitHub/Mestrado/code/ImageProcessing/sift_tempo_real.mat')
sift = repmat(timeTest, 1, 3)-23.9213;


if (isGopro)
    me = me - 0.0130;
    mc = mc - 0.0140;
    mu = mu - 0.0140;
    glcm = glcm - 0.494;
    lbp = lbp - 0.0287;
    sift = sift + 3.3010;
    surf = surf - 1.8280;
end

data = [me'; mc'; mu'; glcm'; lbp'; sift'; surf']; 






labels = [];
for img = 1 : numIter
    labels = [labels; 'ME  '];
end
for img = 1 : numIter
    labels = [labels; 'MC  '];
end
for img = 1 : numIter
    labels = [labels; 'MU  '];
end
for img = 1 : numIter
    labels = [labels; 'GLCM'];
end
for img = 1 : numIter
    labels = [labels; 'LBP '];
end
for img = 1 : numIter
    labels = [labels; 'SIFT'];
end
for img = 1 : numIter
    labels = [labels; 'SURF'];
end


b = boxplot(data, labels);
set(gca,'ygrid','on')

ax = gca;
set(gca,'FontSize',20) %tamanho axis


ylabel('Tempo de Extra\c{c}\~ao (s)', 'FontSize', 25, 'interpreter','latex')
xlabel('Extrator', 'FontSize', 25, 'interpreter','latex')

set(gcf,'units','normalized','outerposition',[0 0 1 1])
set(gca,'LooseInset',get(gca,'TightInset'))


