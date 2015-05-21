close all; clear all; clc; addpath('..'); addpath('../KMeans'); addpath('../bayes');

%Compara a Mistura de Gaussiana com o Bayes

%% Pré-processamento
dados = carregaDados('iris2D.data', 0);

ptrn = 0.75;
numRodadas = 50;

confGM.epocas = 200;
confGM.threshold = 10;
confGM.Ks = [2 1];
confGM.algoritmo = 'mixGaus';

confBayes.custo = 1 - eye(length(unique(dados.y)));
confBayes.algoritmo = '';


for i = 1 : numRodadas,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 2);
    
    %% Treinamento
    tic
    [modeloGM] = trainGausMix(trainData, confGM);
    tempoTreinGM(i) = toc;
    
    tic
    [modeloBayes] = trainBayes(trainData);
    tempoTreinBayes(i) = toc;

    
    %% Avaliando o conjunto de treinamento
    [Yh] = testeGausMix(modeloGM, trainData);
    confusionMatricesTrainGM{i} = confusionmat(trainData.y, Yh);
    accTrainGM(i) = trace(confusionMatricesTrainGM{i}) / length(trainData.y);
    
    [Yh] = testeBayes(modeloBayes, trainData, confBayes);
    confMatTrainBayes{i} = confusionmat(trainData.y, Yh);
    accTrainBayes(i) = trace(confMatTrainBayes{i}) / length(trainData.y);

    %% Teste
    %MG
    tic
    [Yh] = testeGausMix(modeloGM, testData);
    tempoTesteGM(i) = toc/size(testData.y,1);
    
    confusionMatricesTesteGM{i} = confusionmat(testData.y, Yh);
    accTesteGM(i) = trace(confusionMatricesTesteGM{i}) / length(testData.y);

    %Bayes
    tic
    [Yh] = testeBayes(modeloBayes, testData, confBayes);
    tempoTesteBayes(i) = toc/size(testData.y,1);
    
    confMatTesteBayes{i} = confusionmat(testData.y, Yh);
    accTesteBayes(i) = trace(confMatTesteBayes{i}) / length(testData.y);
    
end

%% Mistura de Gaussiana
meanAccuracyGM = mean(accTesteGM);
meanAccuracyTrainGM = mean(accTrainGM);

[~, posicoes] = sort( abs ( meanAccuracyGM - accTesteGM ) );
[~, posicoesTrain] = sort( abs ( meanAccuracyTrainGM - accTrainGM ) );

accMeanGM = meanAccuracyGM*100;
stdGM = std(accTesteGM);
confusionMatrixGM = confusionMatricesTesteGM{posicoes(1)};
accuracyGM = accTesteGM*100;

accMeanTrainGM = meanAccuracyTrainGM*100;
stdTrainGM = std(accTrainGM);
confusionMatrixTrainGM = confusionMatricesTrainGM{posicoesTrain(1)};
accuracyTrainGM = accTrainGM*100;

tempoTesteGM = mean(tempoTesteGM);
tempoTreinGM = mean(tempoTreinGM);


%% Bayes
meanAccuracy = mean(accTesteBayes);
meanAccuracyTrain = mean(accTrainBayes);

[~, posicoes] = sort( abs ( meanAccuracy - accTesteBayes ) );
[~, posicoesTrain] = sort( abs ( meanAccuracyTrain - accTrainBayes ) );

accMeanBayes = meanAccuracy*100;
stdBayes = std(accTesteBayes);
confusionMatrixBayes = confMatTesteBayes{posicoes(1)};
accuracyBayes = accTesteBayes*100;

accMeanTrainBayes = meanAccuracyTrain*100;
stdTrainBayes = std(accTrainBayes);
confusionMatrixTrainBayes = confMatTrainBayes{posicoesTrain(1)};
accTrainBayes = accTrainBayes*100;

tempoTesteBayes = mean(tempoTesteBayes);
tempoTreinBayes = mean(tempoTreinBayes);
clc

%% Resultados
fprintf('Mix Gaus %0.2f %0.2f %0.2f %0.4f %0.4f %0.8f\n', accMeanGM, max(accuracyGM), min(accuracyGM), stdGM, tempoTreinGM, tempoTesteGM) 
fprintf('Bayes    %0.2f %0.2f %0.2f %0.4f %0.4f %0.8f\n', accMeanBayes, max(accuracyBayes), min(accuracyBayes), stdBayes, tempoTreinBayes, tempoTesteBayes) 


%Boxplot
%% Plotando o boxplot
h = figure;
set(h, 'DefaultTextFontSize', 14);
rotulos = [];
for i = 1:numRodadas
    rotulos = [rotulos; 'Mist Gauss'];
end
for i = 1:numRodadas
    rotulos = [rotulos; 'Bayes     '];
end
valores = [accuracyGM accuracyBayes ];
boxplot(valores', rotulos);

ylabel('Acurácia (%)', 'FontSize', 14)
xlabel('Classificador', 'FontSize', 14)



%% Superfície de decisão
% Configurações
% lin = 2; col = 3;
% range = [-1 1 -1 1];
% 
% conf.epocas = 200;
% conf.threshold = 10;
% conf.Ks = [2 1];
% conf.algoritmo = 'mixGaus';
% 
% subplot(lin, col, 1)
% decisionSurface(range, conf, dados, [2 1])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('L. Sépala', 'FontSize', 14);
% 
% subplot(lin, col, 2)
% decisionSurface(range, conf, dados, [3 1])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 3)
% decisionSurface(range, conf, dados, [4 1])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 4)
% decisionSurface(range, conf, dados, [3 2])
% ylabel('L. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 5)
% decisionSurface(range, conf, dados, [4 2])
% ylabel('L. Sépala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 6)
% decisionSurface(range, conf, dados, [4 3])
% ylabel('C. Pétala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);



% lin = 2; col = 3;
% range = [-1 1 -1 1];
% 
% subplot(lin, col, 1)
% decisionSurface(range, confGM, dados, [3 1])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 2)
% decisionSurface(range, confGM, dados, [3 2])
% ylabel('L. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 3)
% decisionSurface(range, confGM, dados, [4 3])
% ylabel('C. Pétala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 4)
% decisionSurface(range, confBayes, dados, [3 1])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 5)
% decisionSurface(range, confBayes, dados, [3 2])
% ylabel('L. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 6)
% decisionSurface(range, confBayes, dados, [4 3])
% ylabel('C. Pétala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);