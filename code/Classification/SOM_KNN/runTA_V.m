close all; clear all; clc; addpath('..');addpath('../SOM');

%% Pré-processamento
dataset = carregaDados('iris.data', 0);

%% Configurações gerais
ptrn = 0.75;


%% Criando as combinações de parâmetros para a validação cruzada

% Topologia da rede
config.vizinhos = 1;
config.topologia = 'h'; %g grid; h hexagonal
config.dist = 'l'; % b boxdist; l linkdist
config.tamanho = [4 4];
config.epocas = 300;
config.K = 3;

combinacoes = combvec([0.1:0.4:1.0],[0.01:0.04:0.1],[0.1:0.4:1],[0.01:0.04:0.1]);

for i = 1 : length(combinacoes)
    config.v_i = combinacoes(1,i);
    config.v_f = combinacoes(2,i);
    config.alfa_i = combinacoes(3,i);
    config.alfa_f = combinacoes(4,i);
    params{i} = config;
end



%%
[trainData, testData] = embaralhaDados(dataset, ptrn, 2);

for i = 1 : length(params)
    
    %% Treinamento da SOM
    fprintf('Treinando a SOM_K-NN...\nRodada %d\n', i)
    [modelo] = trainSOM_KNN(trainData, params{i});
    
    
    %% Testando a SOM
    fprintf('Testando a SOM...\nRodada %d\n\n', i)
    [Yh] = testeSOM_KNN(modelo, testData);
    
    %% Matriz de confusao e acurácia    
    confusionMatrice = confusionmat(testData.y, Yh);
    accuracy(i) = trace(confusionMatrice) / length(find(Yh ~= 0));
    
end

[v, pos] = max(accuracy)
params{pos}

somAlerta()