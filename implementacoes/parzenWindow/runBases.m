close all; clear all; clc; addpath('..');

%% Pré-processamento
dados1 = carregaDados('iris.data', 0);
dados2 = carregaDados('dermatology.data', 0);
dados3 = carregaDados('column_2C.data', 0);
dados4 = carregaDados('column_3C.data', 0);

%% Configurações gerais
ptrn = 0.8;
numRodadas = 10;

r1 = przWinSim( dados1, ptrn, numRodadas, 0.05);
r2 = przWinSim( dados2, ptrn, numRodadas, 0.5);
r3 = przWinSim( dados3, ptrn, numRodadas, 0.1);
r4 = przWinSim( dados4, ptrn, numRodadas, 0.1);

%% Tabela
fprintf('Iris %0.2f %0.2f %0.2f %0.4f\n', r1.accMean, max(r1.accuracy), min(r1.accuracy), r1.std) 
fprintf('Dermat %0.2f %0.2f %0.2f %0.4f\n', r2.accMean, max(r2.accuracy), min(r2.accuracy), r2.std) 
fprintf('Col 2C %0.2f %0.2f %0.2f %0.4f\n', r3.accMean, max(r3.accuracy), min(r3.accuracy), r3.std) 
fprintf('Col 3C %0.2f %0.2f %0.2f %0.4f\n', r4.accMean, max(r4.accuracy), min(r4.accuracy), r4.std) 


%% Plotando o boxplot
f = figure;
set(f, 'DefaultTextFontSize', 14);
rotulos = [];
for i = 1:numRodadas
    rotulos = [rotulos; 'Iris  '];
end
for i = 1:numRodadas
    rotulos = [rotulos; 'Derm  '];
end
for i = 1:numRodadas
    rotulos = [rotulos; 'C.V.2C'];
end
for i = 1:numRodadas
    rotulos = [rotulos; 'C.V.3C'];
end

valores = [r1.accuracy r2.accuracy r3.accuracy r4.accuracy];
boxplot(valores', rotulos);

ylabel('Acurácia', 'FontSize', 14)
xlabel('Base de Dados', 'FontSize', 14)