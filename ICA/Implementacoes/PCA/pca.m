close all; clear all; clc

data = load('../iris.data');
X = data(:,1:4);
Y = data(:,5:end);

X = bsxfun(@minus, X, mean(X));
[V E] = eig( cov(X) );
[E order] = sort(diag(E), 'descend');
V = V(:,order);
pca_data= X*V;

lin = 2;
col = 3;

% 1 C. sepal
% 2 L. sepal
% 3 C. petal
% 4 L. petal


subplot(lin, col, 1)
atrx = 2;
atry = 1;
plot(pca_data(1:50,atrx), pca_data(1:50,atry), 'o', pca_data(51:100,atrx), pca_data(51:100,atry), 'or', pca_data(101:150,atrx), pca_data(101:150,atry), 'og')
ylabel('T. Sépala', 'FontSize', 14);
xlabel('L. Sépala', 'FontSize', 14);
% legend('Setosa', 'Versicolor', 'Virgínica');

subplot(lin, col, 2)
atrx = 3;
atry = 1;
plot(pca_data(1:50,atrx), pca_data(1:50,atry), 'o', pca_data(51:100,atrx), pca_data(51:100,atry), 'or', pca_data(101:150,atrx), pca_data(101:150,atry), 'og')
ylabel('T. Sépala', 'FontSize', 14);
xlabel('T. Pétala', 'FontSize', 14);

subplot(lin, col, 3)
atrx = 4;
atry = 1;
plot(pca_data(1:50,atrx), pca_data(1:50,atry), 'o', pca_data(51:100,atrx), pca_data(51:100,atry), 'or', pca_data(101:150,atrx), pca_data(101:150,atry), 'og')
ylabel('T. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 4)
atrx = 3;
atry = 2;
plot(pca_data(1:50,atrx), pca_data(1:50,atry), 'o', pca_data(51:100,atrx), pca_data(51:100,atry), 'or', pca_data(101:150,atrx), pca_data(101:150,atry), 'og')
ylabel('L. Sépala', 'FontSize', 14);
xlabel('T. Pétala', 'FontSize', 14);

subplot(lin, col, 5)
atrx = 4;
atry = 2;
plot(pca_data(1:50,atrx), pca_data(1:50,atry), 'o', pca_data(51:100,atrx), pca_data(51:100,atry), 'or', pca_data(101:150,atrx), pca_data(101:150,atry), 'og')
ylabel('L. Sépala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);

subplot(lin, col, 6)
atrx = 4;
atry = 3;
plot(pca_data(1:50,atrx), pca_data(1:50,atry), 'o', pca_data(51:100,atrx), pca_data(51:100,atry), 'or', pca_data(101:150,atrx), pca_data(101:150,atry), 'og')
ylabel('T. Pétala', 'FontSize', 14);
xlabel('L. Pétala', 'FontSize', 14);
legend('Setosa ', 'Versicolor ', 'Virgínica', 'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal');