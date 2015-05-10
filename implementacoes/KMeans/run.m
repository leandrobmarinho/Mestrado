close all; clear all; clc; addpath('..');

%% Pré-processamento
dados = carregaDados('iris.data', 0);

%% Configurações gerais
ptrn = 0.75;
numRodadas = 1;

conf.k = 3;
conf.epocas = 200;
r = trainKMeans(dados.x, conf)


cmap = lines(conf.k);
figure
for i=1: conf.k
    plot(r.data.x(r.data.y==i, 1), r.data.x(r.data.y==i, 2), 'o', 'Color', cmap(i,:))
    hold on
end
plot(r.prototypes(:,1), r.prototypes(:,2), '*k')
