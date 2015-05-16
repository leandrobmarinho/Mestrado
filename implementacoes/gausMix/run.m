close all; clear all; clc; addpath('..'); addpath('../KMeans');

%% Pré-processamento
dados = carregaDados('iris2D.data', 0);

%% Configurações gerais
ptrn = 0.75;
numRodadas = 1;

conf.epocas = 200;
conf.threshold = 10;
conf.Ks = [2 1];

%% K-means
[trainData, testData] = embaralhaDados(dados, ptrn, 2);

modelo = trainGausMix(trainData, conf)
[Yh] = testeGausMix(modelo, testData);
trace(confusionmat(testData.y, Yh))/length(Yh)
confusionmat(testData.y, Yh)

%% Plotanto resultados
% atrX = 3; atrY = 4;
% 
% cmap = lines(4);
% figure
% for i=1: 2
%     data = trainData;
%     plot(data.x(data.y==i, atrX), data.x(data.y==i, atrY), 'o', 'Color', cmap(i,:))
%     hold on
%     
% %     data = testData;
% %     plot(data.x(data.y==i, atrX), data.x(data.y==i, atrY), 'd', 'Color', cmap(i+2,:))
% %     hold on
% end

% plot(r.prototypes(:,atrX), r.prototypes(:,atrY), '*k')
% 
% cmap = lines(length(unique(dados.y)));
% figure
% for i=1: length(unique(dados.y))
%     plot(dados.x(dados.y==i, atrX), dados.x(dados.y==i, atrY), '*', 'Color', cmap(i,:))
%     hold on
% end