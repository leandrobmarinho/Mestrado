clear; clc; close all;
titulo_extrator = {'Central M.', 'GLCM', 'Hu', 'LBP', 'Statistical M.', 'SIFT-SURF'};

% load('route_general_gopro.mat');
% for i = 1 : 5
%     dataValues{i} = [valuesNormal(:,i) valuesRej(:,i)]*100;
%     dataErros{i} = [errosNormal(:,i) errosRej(:,i)]*100;
% end
% dataValues{6} = [sift; surf];
% dataErros{6} = [sift_erro; surf_erro];

%% Choose the option
labelY = 'Acur{\''a}cia';


% for i = 0:1
%     figure('name', titulo_extrator{i+1});

%%
%     values = dataValues{i+1};
%     errors = dataErros{i+1};


%% GoPro Virtual
values = [99.68	99.15	98.26	95.49	99.27
    56.19	49.31	36.62	73.99	95.95
    99.40	99.66	98.50	99.45	99.63
    97.22	96.13	91.78	98.83	99.95
    99.57	99.81	99.07	99.32	99.88
    99.89	99.69	98.99	99.65	99.86
    97.30	96.15	92.01	98.86	99.95
    99.57	99.81	99.07	99.33	99.88
    99.89	99.67	98.99	99.65	99.86
    99.15	99.16	96.66	98.82	99.53
    60.39	70.50	65.58	89.85	99.08
    98.83	99.55	98.13	99.02	99.49]';

%% GoPro Real
values = [99.9444	99.9444	97.7083	96.8333	99.5833
55.1667	56	27.375	77.75	99.5833
99.25	99.875	96.5417	99.1667	99.5833
95.6667	97.9167	87.875	99.1667	99.6667
98.9167	99.8333	97.25	98.625	99.6667
99.9583	99.9583	97.5	99.4167	99.8333
95.6667	97.9167	87.875	99.1667	99.6667
98.9167	99.8333	97.25	98.625	99.6667
99.9583	99.9583	97.5	99.4167	99.8333
98	99.3333	93.8333	98.9583	99.1667
96.125	90.6667	59.5	98.0833	99.4167
98.7083	99.6667	94.9167	98.2917	99.625]';

errors = zeros(size(values));

h = errorb(values,errors, 'Color', [0 0 0]);
% grid on
set(gca,'ygrid','on')


% Nome das Legenda
l = {'Bayes', 'LSSVM (Lin)', 'LSSVM (RBF)', 'MLM (Man)', ...
    'MLM (Euc)', 'MLM (Mah)', 'MLM-NN (Man)', ...
    'MLM-NN (Euc)', 'MLM-NN (Mah)', 'MLP', 'SVM (Lin)', 'SVM (RBF)'};
l = legend(h,l,'Orientation', 'vertial');


% ylabel(sprintf('%s (\\%%)', axisName), 'FontSize', 40, 'interpreter','latex')

ylim([min(values(:))-1 101])
xlim([0 size(values,1) + 1])
ax = gca;
set(gca,'FontSize',25) %tamanho axis
set(l,'FontSize',15); %tamanho da legenda

% ============ XTickLabel ============
namesAxisX = {'ME', 'MC', 'MU', 'GLCM', 'LBP'};
set(gca,'XTickLabel', namesAxisX)

%     xlabel('Classifiers', 'FontSize', 40, 'interpreter','latex')

% mycolor=[255/255 128/255 128/255;166/255 166/255 166/255;0 0 0;1 1 1];
%     mycolor=[90/255 50/255 0;166/255 166/255 166/255;0.2 0.2 0.2;1 1 1];
mycolor=[1 1 1; 90/255 50/255 0];

mycolor = [
    247,247,247
    201,148,199
    221,28,119
    222,235,247
    158,202,225
    49,130,189
    229,245,224
    161,217,155
    49,163,84
    153,142,195
    254,196,79
    217,95,14]/255;

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

% end