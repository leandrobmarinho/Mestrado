close all; clear all; clc

%% Carregando os dados
data = load('../iris.data');
dataset.x = data(:, 1:4);
dataset.y = data(:, 5:7);
clear data;

%% Plotando o gráfico
lin = 2; col = 1;

atrx = 4;
atry = 3;
plot(dataset.x(1:50,atrx), dataset.x(1:50,atry), 'o', dataset.x(51:100,atrx), dataset.x(51:100,atry), 'or', dataset.x(101:150,atrx), dataset.x(101:150,atry), 'og')
ylabel('T. Pétala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);
hold on
linha = [min(dataset.x(:,4)) : 0.001: max(dataset.x(:,4))];
plot(linha, 2.3)
hold on
linha = [min(dataset.x(:,3)) : 0.001: max(dataset.x(:,3))];
plot(1.75, linha)
hold on
linha = [min(dataset.x(:,4)) : 0.001: max(dataset.x(:,4))];
plot(linha, 4.95)
hold on
linha = [min(dataset.x(:,3)) : 0.001: max(dataset.x(:,3))];
plot(1.65, linha)
figure,

atr = [1 2 3];
plot3(dataset.x(1:50, atr(1)), dataset.x(1:50, atr(2)), dataset.x(1:50,atr(3)), 'o', dataset.x(51:100,atr(1)), dataset.x(51:100,atr(2)), dataset.x(51:100,atr(3)), 'or', dataset.x(101:150,atr(1)), dataset.x(101:150,atr(2)), dataset.x(101:150,atr(3)), 'og')
xlabel('C. Sépala', 'FontSize', 14);
ylabel('L. Sépala', 'FontSize', 14);
zlabel('C. Pétala', 'FontSize', 14);
