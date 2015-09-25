close all; clear all; clc; addpath('..');

%% Pré-processamento
nameBase = 'dermatology'
dados = carregaDados(strcat(nameBase,'.data'), 0);

%% Configurações gerais
ptrn = 0.8;
numRodadas = 30; %10
h = [0.03 0.05 0.1 0.5 1 2];
% Derm 0.03 0.1 1   - [0.01 0.05 0.1 0.5 1 5]
% Iris 0.005 0.1 1  - [0.003:0.001:0.005 0.01:0.02:0.1 0.1 1 2 7 8]
% Col2C 0.004 0.1 0.3 - [0.002:0.001:0.007 0.01 0.05 0.1 0.3]
% Col3C 0.002 0.1 0.2 - [0.002:0.001:0.007 0.01 0.05 0.1 0.5]


for i = 1 : numRodadas    
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 1);
    
    for j = 1 : length(h);
        fprintf('Passo %d - %d\n', i, j)        
        
        [modelo] = trainPzWin(trainData);
        [Yh] = testePzWin(modelo, testData, h(j));
        
        %% Matriz de confusao e acurácia
        acuracia(i,j) = trace(confusionmat(testData.y, Yh)) / length(testData.y);
        
    end
end

mediaAcc = mean(acuracia);
stdAcc = std(acuracia);
[~, posM] = max(mediaAcc);h(posM)
[~, posSTD] = min(stdAcc);h(posSTD)

%% Plota o gráfico da média
figure
plot(h, mediaAcc, '-ob');
xlabel('h', 'FontSize', 14)
ylabel('Acurácia Média', 'FontSize', 14)

%% Plota o gráfico do std 
% figure
% plot(h, stdAcc, '-or');

save(nameBase);