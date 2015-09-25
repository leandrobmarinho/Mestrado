clear all; close all; clc; addpath('../');


%% Carregando os dados
data = load('coluna_Dtreina.dat');
dadosTrein.x = data(:, 1:6);
dadosTrein.x = normalizaDados(dadosTrein.x,1);
dadosTrein.y = data(:, 7:end);
data = load('coluna_Dteste.dat');
dadosTeste.x = data(:, 1:6);
dadosTeste.x = normalizaDados(dadosTeste.x,1);
dadosTeste.y = data(:, 7:end);
clear data;


%% Configurações
rodadas = 50;
rede.maxIterations = 200;
rede.alfa_i = 0.01;
rede.alfa_f = 0.001;
rede.L = 35;
fileName = 'topologiasMLP';


for i = 1 : rodadas,
    fprintf('MLP - Rodada %d\n', i);
    
    %% Embaralhando os dados
    ind = randperm(size(dadosTrein.y,1));
    dadosTrein.x = dadosTrein.x(ind, :);
    dadosTrein.y = dadosTrein.y(ind, :);
    
    ind = randperm(size(dadosTeste.y,1));
    dadosTeste.x = dadosTeste.x(ind, :);
    dadosTeste.y = dadosTeste.y(ind, :);
    
    %% Treinamento da MLP
    tic
    [modelo{i}] = treinoMLP(dadosTrein, rede);
    tempoTrein(i) = toc;
    
    %% Avaliando o conjunto de treinamento
    [Yh] = testeMLP(modelo{i}, dadosTrein);
    target = vec2ind(dadosTrein.y');
    matConfTreino(:,:,i) = confusionmat(target, Yh);
    accTreino(i) = trace(matConfTreino(:,:,i)) / length(target);
    
    
    %% Testando a MLP
    tic
    Yh = testeMLP(modelo{i}, dadosTeste);
    tempoTeste(i) = toc;
    
    target = vec2ind(dadosTeste.y');
    %% Matriz de confusao e acurácia
    matConfTeste(:,:,i) = confusionmat(target, Yh);
    accTeste(i) = trace(matConfTeste(:,:,i)) / length(target);
    
end

meanAccuracy = mean(accTeste);
meanAccuracyTrain = mean(accTreino);


%% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( meanAccuracy - accTeste ) );
[~, posicoesTrain] = sort( abs ( meanAccuracyTrain - accTreino ) );


%%
accMeanTeste = meanAccuracy*100;
stdTeste = std(accTeste);
confusionMatrix = matConfTeste(:,:,posicoes(1));
confusionMatrices = matConfTeste;
accuracy = accTeste*100;
modelos = modelo;

accMeanTreino = meanAccuracyTrain*100;
confusionMatrixTrain = matConfTreino(:,:,posicoesTrain(1));
stdTrain = std(accTreino);
accTreino = accTreino*100;

