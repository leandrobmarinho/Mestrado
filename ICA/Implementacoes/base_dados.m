close all; clear all; clc

data = load('iris.data');

lin = 2;
col = 3;

% 1 T. sepal 
% 2 L. sepal
% 3 T. petal
% 4 L. petal


subplot(lin, col, 1)
atrx = 2;
atry = 1;
plot(data(1:50,atrx), data(1:50,atry), 'o', data(51:100,atrx), data(51:100,atry), 'or', data(101:150,atrx), data(101:150,atry), 'og')
ylabel('T. Sépala', 'FontSize', 14);
xlabel('L. Sépala', 'FontSize', 14);
% legend('Setosa', 'Versicolor', 'Virgínica');

subplot(lin, col, 2)
atrx = 3;
atry = 1;
plot(data(1:50,atrx), data(1:50,atry), 'o', data(51:100,atrx), data(51:100,atry), 'or', data(101:150,atrx), data(101:150,atry), 'og')
ylabel('T. Sépala', 'FontSize', 14);
xlabel('T. Pétala', 'FontSize', 14);

subplot(lin, col, 3)
atrx = 4;
atry = 1;
plot(data(1:50,atrx), data(1:50,atry), 'o', data(51:100,atrx), data(51:100,atry), 'or', data(101:150,atrx), data(101:150,atry), 'og')
ylabel('T. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 4)
atrx = 3;
atry = 2;
plot(data(1:50,atrx), data(1:50,atry), 'o', data(51:100,atrx), data(51:100,atry), 'or', data(101:150,atrx), data(101:150,atry), 'og')
ylabel('L. Sépala', 'FontSize', 14);
xlabel('T. Pétala', 'FontSize', 14);

subplot(lin, col, 5)
atrx = 4;
atry = 2;
plot(data(1:50,atrx), data(1:50,atry), 'o', data(51:100,atrx), data(51:100,atry), 'or', data(101:150,atrx), data(101:150,atry), 'og')
ylabel('L. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 6)
atrx = 4;
atry = 3;
plot(data(1:50,atrx), data(1:50,atry), 'o', data(51:100,atrx), data(51:100,atry), 'or', data(101:150,atrx), data(101:150,atry), 'og')
ylabel('T. Pétala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);
legend('Setosa ', 'Versicolor ', 'Virgínica', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal');

% figure,
% plot3(data(1:50,2), data(1:50,3), data(1:50,4), 'o', data(51:100,2), data(51:100,3), data(51:100,4), 'or', data(101:150,2), data(101:150,3), data(101:150,4), 'og')