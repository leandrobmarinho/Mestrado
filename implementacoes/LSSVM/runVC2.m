close all; clear all; clc; addpath('..');

%% Pré-processamento
dados = carregaDados('haberman.data', 4);

%% Configurações gerais
ptrn = 0.8;
numRodadas = 30;
numFolds = 10;


%% Criando as combinações de parâmetros para a validação cruzada

% Sigma do kernel rbf
gamma = [0.001:0.01:0.1 1:60];
gamma = 2.^(-5:2:13);
% gamma = 1:32;

% sigma = 0.001:0.01:1;
% sigma = 2.^(-15:2:5);
% sigma = 1:10;

i = 1;
if (exist('sigma') == 1)
    for g = gamma
        for s = sigma
            params{i}.gamma = g;
            params{i}.sigma = s;
            i = i + 1;
        end
    end
else
    for g = gamma
        params{i}.gamma = g;
        i = i + 1;
    end
end


%% Avaliando o método
for i = 1 : numRodadas,
    %% Embaralhando os dados
    [dadosTrein, dadosTeste] = embaralhaDados(dados, ptrn, 2);
    
    
    %% Validação cruzada e busca em grade
    fprintf('Cross validation and grid search...\n')
    [optParams{i}, Ecv{i}] = otimizadorLSSVM(dadosTrein, params, numFolds);
    
    %% Treinamento o LSSVM
    fprintf('Treinando o LSSVM...\nRodada %d\n', i)
    
    modelo = MyLSSVM(dadosTrein.x, dadosTrein.y, optParams{i});
    tic
    modelo.train();
    tempoTreino(i) = toc;
    numSV(i) = length(modelo.alphas);
    
    %% Testando o LSSVM
    fprintf('Testando o LSSVM...\nRodada %d\n\n', i)
    tic
    Yh = modelo.classify(dadosTeste.x);
    tempoTeste(i) = toc/size(Yh,1);
        
    % Matriz de confusao e acurácia    
    matrizesConf{i} = confusionmat(dadosTeste.y, Yh);
    acuracia(i) = trace(matrizesConf{i}) / size(Yh,1);
end

mediaAcc = mean(acuracia);

% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( mediaAcc - acuracia ) );


desvPadr = std(acuracia);
matrizConfMedia = matrizesConf{posicoes(1)};
clear Yh dadosTeste dadosTrein i posicoes

% [X, Y] = meshgrid(sigma, gamma);
% mesh(X, Y, reshape(Ecv{1}, length(gamma), length(sigma)))

%%
% for i = 1 : 88
% aux(1, i) = params{1,i};
% aux(2, i) = params{3,i};
% end
% tri = delaunay(aux(1,:), aux(2,:));
% trimesh(tri,aux(1,:), aux(2,:), Ecv{1}(1:88));
% colormap('winter')
