close all; clear all; clc; addpath('..');

%% Pré-processamento
dados = carregaDados('column_2C.data', 4);

%% Configurações gerais
ptrn = 0.8;
numRodadas = 10;
numFolds = 10;


%% Criando as combinações de parâmetros para a validação cruzada

gammas = 0.001:0.01:0.1;


%% Avaliando o método
for i = 1 : numRodadas,
    %% Embaralhando os dados
    [dadosTrein, dadosTeste] = embaralhaDados(dados, ptrn, 2);
    
    
    %% Validação cruzada
    fprintf('Cross validation and grid search...\n')
    [optParams{i}, Ecv{i}] = otimizadorLSSVM(dadosTrein, gammas, numFolds);
    
    
    %% Treinamento do SVM
    fprintf('Treinando o LSSVM...\nRodada %d\n', i)
    
    modelo = MyLSSVM(dadosTrein.x, dadosTrein.y, optParams{i});
    modelo.train();
    
    Yh = modelo.classify(dadosTeste.x);
        
    % Matriz de confusao e acurácia    
    matrizesConf{i} = confusionmat(dadosTeste.y, Yh);
    acuracia(i) = trace(matrizesConf{i}) / size(Yh,1);
end

mediaAcc = mean(acuracia);

% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( mediaAcc - acuracia ) );


desvPadr = std(acuracia);
matrizConfMedia = matrizesConf{posicoes(1)};
clear Yh dados dadosTeste dadosTrein i posicoes