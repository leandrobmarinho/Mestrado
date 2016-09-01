clear; clc; close all;
titulo_extrator = {'Central M.', 'GLCM', 'Hu', 'LBP', 'Statistical M.', 'SIFT-SURF'};

load('route_general_gopro.mat');
for i = 1 : 5
    dataValues{i} = [valuesNormal(:,i) valuesRej(:,i)]*100;
    dataErros{i} = [errosNormal(:,i) errosRej(:,i)]*100;
end
dataValues{6} = [sift; surf];
dataErros{6} = [sift_erro; surf_erro];

%% Choose the option
labelY = 'Acur{\''a}cia';


for i = 0:5
    figure('name', titulo_extrator{i+1});
    
    %%
    values = dataValues{i+1};
    errors = dataErros{i+1};
    
    h = errorb(values,errors, 'Color', [0 0 0]);
    % grid on
    set(gca,'ygrid','on')
    
    
    % Nome das Legenda
    l = {'Normal', 'Com SDL'};
    l = legend(h,l,'Location','northoutside', 'Orientation', 'horizontal');
    
    
    % ylabel(sprintf('%s (\\%%)', axisName), 'FontSize', 40, 'interpreter','latex')
    
    ylim([0 105])
    xlim([0 size(values,1) + 1])
    ax = gca;
    set(gca,'FontSize',25) %tamanho axis
    set(l,'FontSize',30); %tamanho da legenda
    
    % ============ XTickLabel ============
    if (size(values,1) == 2)
        namesAxisX = {'SIFT', 'SURF'};
    else
        namesAxisX = {'Bayes', 'LSSVM (Lin)', 'LSSVM (RBF)', 'MLM (Man)', ...
            'MLM (Euc)', 'MLM (Mah)', 'MLM-NN (Man)', ...
            'MLM-NN (Euc)', 'MLM-NN (Mah)', 'MLP', 'SVM (Lin)', 'SVM (RBF)'};        
    end
    set(gca,'XTickLabel', namesAxisX)
    if (size(values,1) > 2)
            ax.XTickLabelRotation = 22;
    end

%     xlabel('Classifiers', 'FontSize', 40, 'interpreter','latex')
    
    % mycolor=[255/255 128/255 128/255;166/255 166/255 166/255;0 0 0;1 1 1];
%     mycolor=[90/255 50/255 0;166/255 166/255 166/255;0.2 0.2 0.2;1 1 1];
    mycolor=[1 1 1; 90/255 50/255 0];
    colormap(mycolor)
    
    
    % ==== Linha do maior valor ====
    hold on
    xmax=0:(size(values,1)+2);
    ymax = repmat(max(values(:)), 1, length(xmax));
    plot(xmax, ymax, '--', 'LineWidth',2, 'Color', [0.5 0.5 0.5])
    
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
    ylabel(labelY, 'FontSize', 40, 'interpreter','latex')
    xlhand = get(gca,'ylabel');
    xlhand.FontSize = 40;
    
    
    set(gca,'LooseInset',get(gca,'TightInset'))
%     set(gcf, 'PaperSize', [6.25 7.5]);
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [0 0 6.25 7.5]);
%     
%     set(gcf, 'PaperUnits', 'inches');
%     set(gcf, 'PaperSize', [6.25 7.5]);
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [0 0 6.25 7.5]);
%     
%     set(gcf, 'renderer', 'painters');
%     print(gcf, '-dpdf', 'my-figure.pdf');
%     print(gcf, '-dpng', 'my-figure.png');
%     print(gcf, '-depsc2', 'my-figure.eps');
        
    % Imprime o menor valor
    v = min(values(:));
    [lin,~] = find(values == v);
%     fprintf('%s. \tMenor: %.2f. Mascara: %s\n', titulo_extrator{i+1}, v, namesAxisX{lin});
end