close all; clear all; clc; addpath('..'); addpath('../KMeans'); addpath('../bayes');

%Compara a Mistura de Gaussiana com o Bayes

%% Pré-processamento
dados = carregaDados('haberman.data', 0);
% coluna .15
% diabetes .35
% breast_cancer .25
% haberman .25

ptrn = 0.75;
numRodadas = 50;

confRej.algoritmo = 'bayesRej';
confRej.t = .25;

confBayes.custo = 1 - eye(length(unique(dados.y)));
confBayes.algoritmo = '';


for i = 1 : numRodadas,
    %% Embaralhando os dados
    [trainData, testData] = embaralhaDados(dados, ptrn, 2);
    
    %% Treinamento    
    [modelo] = trainBayes(trainData);

    
    %% Avaliando o conjunto de treinamento
    [Yh] = testeBayes(modelo, trainData, confRej);
    confusionMatricesTrainRej{i} = confusionmat(trainData.y, Yh);
    accTrainRej(i) = trace(confusionMatricesTrainRej{i}) / length(trainData.y);
    
    [Yh] = testeBayes(modelo, trainData, confBayes);
    confMatTrainBayes{i} = confusionmat(trainData.y, Yh);
    accTrainBayes(i) = trace(confMatTrainBayes{i}) / length(trainData.y);

    %% Teste
    %Rejeição
    [Yh] = testeBayes(modelo, testData, confRej);
    
    confusionMatricesTesteRej{i} = confusionmat(testData.y, Yh);
    accTesteRej(i) = trace(confusionMatricesTesteRej{i}) / length(find(Yh ~= 0));
    rejeicao(i) = length(find(Yh == 0)) / length(testData.y);

    %Bayes
    [Yh] = testeBayes(modelo, testData, confBayes);
    
    confMatTesteBayes{i} = confusionmat(testData.y, Yh);
    accTesteBayes(i) = trace(confMatTesteBayes{i}) / length(testData.y);
    
end

%% Bayes com Rejeição
meanAccuracyRej = mean(accTesteRej);
meanAccuracyTrainRej = mean(accTrainRej);

[~, posicoes] = sort( abs ( meanAccuracyRej - accTesteRej ) );
[~, posicoesTrain] = sort( abs ( meanAccuracyTrainRej - accTrainRej ) );

accMeanRej = meanAccuracyRej*100;
stdRej = std(accTesteRej);
confMatRej = confusionMatricesTesteRej{posicoes(1)};
accuracyRej = accTesteRej*100;

accMeanTrainRej = meanAccuracyTrainRej*100;
stdTrainRej = std(accTrainRej);
confMatTrainRej = confusionMatricesTrainRej{posicoesTrain(1)};
accuracyTrainRej = accTrainRej*100;


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



%% Resultados
fprintf('Reje  %0.2f %0.2f %0.2f %0.4f %0.2f\n', accMeanRej, max(accuracyRej), min(accuracyRej), stdRej, mean(rejeicao)) 
fprintf('Bayes %0.2f %0.2f %0.2f %0.4f \n', accMeanBayes, max(accuracyBayes), min(accuracyBayes), stdBayes) 


%Boxplot
%% Plotando o boxplot
h = figure;
set(h, 'DefaultTextFontSize', 14);
rotulos = [];
for i = 1:numRodadas
    rotulos = [rotulos; 'Bayes Rej'];
end
for i = 1:numRodadas
    rotulos = [rotulos; 'Bayes    '];
end
valores = [accuracyRej accuracyBayes ];
boxplot(valores', rotulos);

ylabel('Acurácia (%)', 'FontSize', 14)
xlabel('Classificador', 'FontSize', 14)



%% Superfície de decisão
% Configurações
% lin = 2; col = 3;
% range = [-1 1 -1 1];
% 
% subplot(lin, col, 1)
% decisionSurface(range, confRej, dados, [2 1])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 2)
% decisionSurface(range, confRej, dados, [3 1])
% ylabel('L. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 3)
% decisionSurface(range, confRej, dados, [4 1])
% ylabel('C. Pétala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 4)
% decisionSurface(range, confRej, dados, [3 2])
% ylabel('C. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 5)
% decisionSurface(range, confRej, dados, [4 2])
% ylabel('L. Sépala', 'FontSize', 14);
% xlabel('C. Pétala', 'FontSize', 14);
% 
% subplot(lin, col, 6)
% decisionSurface(range, confRej, dados, [4 3])
% ylabel('C. Pétala', 'FontSize', 14);
% xlabel('L. Pétala', 'FontSize', 14);






lin = 2; col = 3;
range = [-1 1 -1 1];

subplot(lin, col, 1)
decisionSurface(range, confRej, dados, [1 2])
ylabel('2', 'FontSize', 14);
xlabel('1', 'FontSize', 14);

subplot(lin, col, 2)
decisionSurface(range, confRej, dados, [1 3])
ylabel('3', 'FontSize', 14);
xlabel('1', 'FontSize', 14);

subplot(lin, col, 3)
decisionSurface(range, confRej, dados, [2 3])
ylabel('3', 'FontSize', 14);
xlabel('2', 'FontSize', 14);

subplot(lin, col, 4)
decisionSurface(range, confBayes, dados, [1 2])
ylabel('2', 'FontSize', 14);
xlabel('1', 'FontSize', 14);

subplot(lin, col, 5)
decisionSurface(range, confBayes, dados, [1 3])
ylabel('3', 'FontSize', 14);
xlabel('1', 'FontSize', 14);

subplot(lin, col, 6)
decisionSurface(range, confBayes, dados, [2 3])
ylabel('3', 'FontSize', 14);
xlabel('2', 'FontSize', 14);