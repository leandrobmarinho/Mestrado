close all; clear all; clc; addpath('..');

%% Configurações gerais
ptrn = 0.8;
limiares = 0.01 : 0.01 :0.5 ;
config.method = 'knn'; % lsqnonlin knn ''
config.k = 1;
config.NN = 9;
config.distance = '';

conf.pca = 0.98;
i = 1;
for limiar = limiares
    
    % Pré-processamento
    conf.selecaoAtr = limiar; %0.015 0.1 0.45 0.07 0.03
    dados = carregaDados('har', 1, conf);
    numAtributos(i) = size(dados.x, 2);
    
    %% Embaralhando os dados
    [dadosTrein, dadosTeste] = embaralhaDados(dados, 0.8, 2);    
    clear dados;
    
    %% Treinamento
    fprintf('Treinando a MLM.\n');
    [modelo] = train_MLM(dadosTrein, config);
    
    
    %% Teste
    fprintf('Testando a MLM.\n');
    [Y] = test_MLM(modelo, dadosTeste, config);
    confMat = confusionmat(vec2ind(dadosTeste.y'), vec2ind(Y'));
    acuracia(i) = trace(confMat)/size(dadosTeste.y,1);
    i = i + 1;
end
save('limiares');