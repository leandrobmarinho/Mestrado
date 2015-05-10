close all; clear all; clc; addpath('..');

%% Iris
dataset = carregaDados('iris.data', 0);

lin = 2; col = 3;
range = [-1 1 -1 1];
conf.algoritmo = 'janelaParzen';
conf.h = 0.05;

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


%% Coluna Vertebral 3C
dataset = carregaDados('column_3C.data', 0, -1);

% 1 pelvic incidence
% 2 pelvic tilt
% 3 lumbar lordosis angle
% 4 sacral slope
% 5 pelvic radius
% 6 grade of spondylolisthesis

lin = 3; col = 3;
range = [-1 1 -1 1];
conf.algoritmo = 'janelaParzen';
conf.h = 0.1;

subplot(lin, col, 1)
decisionSurface(range, conf, dataset, [1 2])
ylabel('pelvic incidence', 'FontSize', 14);
xlabel('pelvic tilt', 'FontSize', 14);

subplot(lin, col, 2)
decisionSurface(range, conf, dataset, [1 3])
ylabel('pelvic incidence', 'FontSize', 14);
xlabel('lumbar lordosis angle', 'FontSize', 14);

subplot(lin, col, 3)
decisionSurface(range, conf, dataset, [1 4])
ylabel('pelvic incidence', 'FontSize', 14);
xlabel('sacral slope', 'FontSize', 14);

subplot(lin, col, 4)
decisionSurface(range, conf, dataset, [1 5])
ylabel('pelvic incidence', 'FontSize', 14);
xlabel('pelvic radius', 'FontSize', 14);

subplot(lin, col, 5)
decisionSurface(range, conf, dataset, [1 6])
ylabel('pelvic incidence', 'FontSize', 14);
xlabel('grade of spondylolisthesis', 'FontSize', 14);

subplot(lin, col, 6)
decisionSurface(range, conf, dataset, [2 3])
ylabel('pelvic tilt', 'FontSize', 14);
xlabel('lumbar lordosis angle', 'FontSize', 14);


subplot(lin, col, 7)
decisionSurface(range, conf, dataset, [2 4])
ylabel('pelvic tilt', 'FontSize', 14);
xlabel('sacral slope', 'FontSize', 14);

subplot(lin, col, 8)
decisionSurface(range, conf, dataset, [2 5])
ylabel('pelvic tilt', 'FontSize', 14);
xlabel('pelvic radius', 'FontSize', 14);

subplot(lin, col, 9)
decisionSurface(range, conf, dataset, [2 6])
ylabel('pelvic tilt', 'FontSize', 14);
xlabel('grade of spondylolisthesis', 'FontSize', 14);

figure
lin = 2;

subplot(lin, col, 1)
decisionSurface(range, conf, dataset, [3 4])
ylabel('lumbar lordosis angle', 'FontSize', 14);
xlabel('sacral slope', 'FontSize', 14);

subplot(lin, col, 2)
decisionSurface(range, conf, dataset, [3 5])
ylabel('lumbar lordosis angle', 'FontSize', 14);
xlabel('pelvic radius', 'FontSize', 14);

subplot(lin, col, 3)
decisionSurface(range, conf, dataset, [3 6])
ylabel('lumbar lordosis angle', 'FontSize', 14);
xlabel('grade of spondylolisthesis', 'FontSize', 14);

subplot(lin, col, 4)
decisionSurface(range, conf, dataset, [4 5])
ylabel('sacral slope', 'FontSize', 14);
xlabel('pelvic radius', 'FontSize', 14);

subplot(lin, col, 5)
decisionSurface(range, conf, dataset, [4 6])
ylabel('sacral slope', 'FontSize', 14);
xlabel('grade of spondylolisthesis', 'FontSize', 14);

subplot(lin, col, 6)
decisionSurface(range, conf, dataset, [5 6])
ylabel('pelvic radius', 'FontSize', 14);
xlabel('grade of spondylolisthesis', 'FontSize', 14);