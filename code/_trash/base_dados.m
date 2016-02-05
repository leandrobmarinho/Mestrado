close all; clear all; clc

load fisheriris
data = meas;
% data = load('iris.data');

lin = 2;
col = 3;
fontSize = 14;
markesize = 18;

% 1 C. sepal 
% 2 L. sepal
% 3 C. petal
% 4 L. petal


subplot(lin, col, 1)
atrx = 2;
atry = 1;
% h = plot(data(1:50,atrx), data(1:50,atry), '.b', data(51:100,atrx), data(51:100,atry), '.r', data(101:150,atrx), data(101:150,atry), '.g');
plot(data(1:50,atrx), data(1:50,atry), '.b', 'Markersize', markesize);
hold on
plot( data(51:100,atrx), data(51:100,atry), '.r', 'Markersize', markesize);
hold on
plot(data(101:150,atrx), data(101:150,atry), '.g', 'Markersize', markesize);
ylabel('C. Sepala', 'FontSize', fontSize);
xlabel('L. Sepala', 'FontSize', fontSize);

subplot(lin, col, 2)
atrx = 3;
atry = 1;
plot(data(1:50,atrx), data(1:50,atry), '.b', 'Markersize', markesize);
hold on
plot( data(51:100,atrx), data(51:100,atry), '.r', 'Markersize', markesize);
hold on
plot(data(101:150,atrx), data(101:150,atry), '.g', 'Markersize', markesize);
ylabel('C. Sepala', 'FontSize', fontSize);
xlabel('C. Petala', 'FontSize', fontSize);

subplot(lin, col, 3)
atrx = 4;
atry = 1;
plot(data(1:50,atrx), data(1:50,atry), '.b', 'Markersize', markesize);
hold on
plot( data(51:100,atrx), data(51:100,atry), '.r', 'Markersize', markesize);
hold on
plot(data(101:150,atrx), data(101:150,atry), '.g', 'Markersize', markesize);
ylabel('C. Sepala', 'FontSize', fontSize);
xlabel('L. Petala', 'FontSize', fontSize);

subplot(lin, col, 4)
atrx = 3;
atry = 2;
plot(data(1:50,atrx), data(1:50,atry), '.b', 'Markersize', markesize);
hold on
plot( data(51:100,atrx), data(51:100,atry), '.r', 'Markersize', markesize);
hold on
plot(data(101:150,atrx), data(101:150,atry), '.g', 'Markersize', markesize);
ylabel('L. Sepala', 'FontSize', fontSize);
xlabel('C. Petala', 'FontSize', fontSize);

subplot(lin, col, 5)
atrx = 4;
atry = 2;
plot(data(1:50,atrx), data(1:50,atry), '.b', 'Markersize', markesize);
hold on
plot( data(51:100,atrx), data(51:100,atry), '.r', 'Markersize', markesize);
hold on
plot(data(101:150,atrx), data(101:150,atry), '.g', 'Markersize', markesize);
ylabel('L. Sepala', 'FontSize', fontSize);
xlabel('L. Petala', 'FontSize', fontSize);

subplot(lin, col, 6)
atrx = 4;
atry = 3;
plot(data(1:50,atrx), data(1:50,atry), '.b', 'Markersize', markesize);
hold on
plot( data(51:100,atrx), data(51:100,atry), '.r', 'Markersize', markesize);
hold on
plot(data(101:150,atrx), data(101:150,atry), '.g', 'Markersize', markesize);
ylabel('C. Petala', 'FontSize', fontSize);
xlabel('L. Petala', 'FontSize', fontSize);
l = legend('Setosa ', 'Versicolor ', 'Virgenica', 'Location',[0.35,0.94,0.35,0.05], 'Orientation','Horizontal');
set(l,'FontSize',16);
% [0.35,0.01,0.35,0.05]
% figure,
% plot3(data(1:50,2), data(1:50,3), data(1:50,4), '.', data(51:100,2), data(51:100,3), data(51:100,4), '.r', data(101:150,2), data(101:150,3), data(101:150,4), '.g')