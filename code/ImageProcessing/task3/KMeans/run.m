close all; clear all; clc; addpath('../');

%% Pr?-processamento
dados = carregaDados('iris2D.data', 0);

%% Configura??es gerais
ptrn = 0.75;
numRodadas = 1;
conf.epocas = 200;
conf.k = 2;
classe = 1;

%% K-means
X = dados.x(dados.y == classe, :);
r = trainKMeans(dados.x, conf)


%% Plotanto resultados
atrX = 3; atrY = 2;

cmap = lines(conf.k);
figure
for i=1: conf.k
    plot(r.data.x(r.data.y==i, atrX), r.data.x(r.data.y==i, atrY), 'o', 'Color', cmap(i,:))
    hold on
end
plot(r.prototypes(:,atrX), r.prototypes(:,atrY), '*k')

cmap = lines(length(unique(dados.y)));
figure
for i=1: length(unique(dados.y))
    plot(dados.x(dados.y==i, atrX), dados.x(dados.y==i, atrY), '*', 'Color', cmap(i,:))
    hold on
end