clear; clc; close all;
titulo_extrator = {'Central M.', 'GLCM', 'Hu', 'LBP', 'Statistical M.'};

load('extracao.mat');

%% Choose the option
labelY = 'Tempo';


for i = 0 : 3
    figure('name', titulo_extrator{i+1});
    
    %%
    values = [meanTimes(i + 1,:)' meanTimes(i + 4,:)' meanTimes(i + 8,:)'];
    errors = [meanTimesstd(i + 1,:)' meanTimesstd(i + 4,:)' meanTimesstd(i + 8,:)'];
    
    h = errorb(values,errors, 'Color', [0 0 0]);
    % grid on
    set(gca,'ygrid','on')
    
    
    % Nome das Legenda
    l = {'Euclidiana', 'Gaussiana', 'Mahalanobis'};
    l = legend(h,l,'Location','northoutside', 'Orientation', 'horizontal');
    
    
    % ylabel(sprintf('%s (\\%%)', axisName), 'FontSize', 40, 'interpreter','latex')
    ylabel(labelY, 'FontSize', 40, 'interpreter','latex')
    xlabel('Vizinhan\c{c}a', 'FontSize', 40, 'interpreter','latex')
    
    ylim([0 max(values(:))+ max(errors(:))])
    xlim([0 size(values,1) + 1])
    set(gca,'FontSize',30) %tamanho axis
    set(l,'FontSize',25); %tamanho da legenda
    
    
    % ============ XTickLabel ============
    namesAxisX = {'3x3', '5x5', '7x7', '9x9', '11x11', '13x13', '15x15'};
    set(gca,'XTickLabel', namesAxisX)
    
    
    % mycolor=[255/255 128/255 128/255;166/255 166/255 166/255;0 0 0;1 1 1];
    mycolor=[90/255 50/255 0;166/255 166/255 166/255;0.2 0.2 0.2;1 1 1];
    colormap(mycolor)
    
    
    % ==== Linha do maior valor ====
    hold on
    xmax=0:(size(values,1)+2);
    ymax = repmat(min(values(:)), 1, length(xmax));
    plot(xmax, ymax, '--', 'LineWidth',2, 'Color', [0,0.1,0.1])
    
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
    
    % Imprime o menor valor
    v = min(values(:));
    [lin,~] = find(values == v);
    fprintf('%s. \tMenor: %.2f. Mascara: %s\n', titulo_extrator{i+1}, v, namesAxisX{lin});
end