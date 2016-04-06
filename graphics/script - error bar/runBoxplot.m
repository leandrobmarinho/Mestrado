clear all; clc;

%% Alterar o caminho do arquivo e o nome final do gr?fico
nameFile = 'findcontours_photo_acc';
pathName = 'FindContours/Photo/Metrics_Find_Photo/Accuracy_Find_Photo.txt';


%%
data = load(sprintf('../Metricas/MetricsResults/%s', pathName));
numIter = size(data,2);
numImgs = size(data,1);

h = figure;
set(h, 'DefaultTextFontSize', 14);

labels = [];
for img = 1 : numImgs
    if (img < 10)
        name = sprintf('Img%d ', img);
    else
        name = sprintf('Img%d', img);
    end
    for i = 1:numIter
        labels = [labels; name];
    end
end

valours = reshape(data', 1, numIter*numImgs);
boxplot(valours', labels);

ylabel('Acur$\acute{a}$cia (\%)', 'FontSize', 18, 'interpreter','latex')
xlabel('Imagem', 'FontSize', 18, 'interpreter','latex')

print(sprintf('%s_boxplot', nameFile),'-depsc')