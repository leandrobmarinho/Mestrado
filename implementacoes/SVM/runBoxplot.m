%% Plotando o boxplot
h = figure;
set(h, 'DefaultTextFontSize', 14);
rotulos = [];
numRodadas = 30;
for i = 1:numRodadas
    rotulos = [rotulos; '  SVM/QP/LIN'];
end
for i = 1:numRodadas
    rotulos = [rotulos; '  SVM/QP/RBF'];
end
for i = 1:numRodadas
    rotulos = [rotulos; ' SVM/SMO/LIN'];
end
for i = 1:numRodadas
    rotulos = [rotulos; ' SVM/SMO/RBF'];
end
for i = 1:numRodadas
    rotulos = [rotulos; 'LSSVM/MI/LIN'];
end
for i = 1:numRodadas
    rotulos = [rotulos; 'LSSVM/MI/RBF'];
end
% valores = [resultCOMP.accuracy resultMVAR.accuracy resultEUCLI.accuracy resultMAHALA1.accuracy resultMAHALA2.accuracy resultMAHALA3.accuracy];
boxplot(valor', rotulos);

ylabel('Acurácia', 'FontSize', 18)
xlabel('Classificador', 'FontSize', 18)