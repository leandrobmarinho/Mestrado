close all; clear all; clc
addpath('..');

%% Pré-processamento
dataset = carregaDados('column_2C.data', 0);


%% Configurações gerais
ptrn = 0.75;
numRepet = 20;

conf.custo = 1 - eye(length(unique(dataset.y)));
conf.algoritmo = '';
resultCOMP = bayes(dataset, ptrn, numRepet, conf);

conf.algoritmo = 'sameVar';
resultMVAR = bayes(dataset, ptrn, numRepet, conf);

conf.algoritmo = 'euclidean';
resultEUCLI = bayes(dataset, ptrn, numRepet, conf);

conf.algoritmo = 'mahalanobis1';
resultMAHALA1 = bayes(dataset, ptrn, numRepet, conf);

conf.algoritmo = 'mahalanobis2';
resultMAHALA2 = bayes(dataset, ptrn, numRepet, conf);

conf.algoritmo = 'mahalanobis3';
resultMAHALA3 = bayes(dataset, ptrn, numRepet, conf);

fprintf('Comp %0.2f %0.2f %0.2f %0.4f\n', resultCOMP.accMean, max(resultCOMP.accuracy), min(resultCOMP.accuracy), resultCOMP.std) 
fprintf('MVAR %0.2f %0.2f %0.2f %0.4f\n', resultMVAR.accMean, max(resultMVAR.accuracy), min(resultMVAR.accuracy), resultMVAR.std)
fprintf('EUCL %0.2f %0.2f %0.2f %0.4f\n', resultEUCLI.accMean, max(resultEUCLI.accuracy), min(resultEUCLI.accuracy), resultEUCLI.std)
fprintf('MAH1 %0.2f %0.2f %0.2f %0.4f\n', resultMAHALA1.accMean, max(resultMAHALA1.accuracy), min(resultMAHALA1.accuracy), resultMAHALA1.std)
fprintf('MAH2 %0.2f %0.2f %0.2f %0.4f\n', resultMAHALA2.accMean, max(resultMAHALA2.accuracy), min(resultMAHALA2.accuracy), resultMAHALA2.std)
fprintf('MAH3 %0.2f %0.2f %0.2f %0.4f\n', resultMAHALA3.accMean, max(resultMAHALA3.accuracy), min(resultMAHALA3.accuracy), resultMAHALA3.std)

[~, a] = sort([resultCOMP.accMean resultMVAR.accMean resultEUCLI.accMean resultMAHALA1.accMean resultMAHALA2.accMean resultMAHALA3.accMean])


%% Plotando o boxplot
h = figure;
set(h, 'DefaultTextFontSize', 14);
rotulos = [];
for i = 1:numRepet
    rotulos = [rotulos; 'Bayes 1'];
end
for i = 1:numRepet
    rotulos = [rotulos; 'Bayes 2'];
end
for i = 1:numRepet
    rotulos = [rotulos; 'D.E.   '];
end
for i = 1:numRepet
    rotulos = [rotulos; 'D.M. 1 '];
end
for i = 1:numRepet
    rotulos = [rotulos; 'D.M. 2 '];
end
for i = 1:numRepet
    rotulos = [rotulos; 'D.M. 3 '];
end
valores = [resultCOMP.accuracy resultMVAR.accuracy resultEUCLI.accuracy resultMAHALA1.accuracy resultMAHALA2.accuracy resultMAHALA3.accuracy];
boxplot(valores', rotulos);

ylabel('Acurácia', 'FontSize', 14)
xlabel('Classificador', 'FontSize', 14)


%% Superfície de decisão
% Configurações
lin = 2; col = 3;
range = [-1 1 -1 1];
conf.algoritmo = '';

subplot(lin, col, 1)
decisionSurface(range, conf, dataset, [2 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('L. Sépala', 'FontSize', 14);

subplot(lin, col, 2)
decisionSurface(range, conf, dataset, [3 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

subplot(lin, col, 3)
decisionSurface(range, conf, dataset, [4 1])
ylabel('C. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 4)
decisionSurface(range, conf, dataset, [3 2])
ylabel('L. Sépala', 'FontSize', 14);
xlabel('C. Pétala', 'FontSize', 14);

subplot(lin, col, 5)
decisionSurface(range, conf, dataset, [4 2])
ylabel('L. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 6)
decisionSurface(range, conf, dataset, [4 3])
ylabel('C. Pétala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);