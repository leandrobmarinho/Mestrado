clear all; close all; clc; addpath('..');

%% Carregando dados
conf.pca = 0.98;
conf.selecaoAtr = 0.1;
dados = carregaDados('har', 1, conf);


%% Configurações gerais
ptrn = 0.8;

%% Criando as combinações de parâmetros
numTreino = 2;
neur = [30 100 110 500 600 800];

save('topologiaMLP_ToolBox');
for i = 1 : numTreino
    [learnPoints{i}, testData{i}] = embaralhaDados(dados, ptrn, 2);
    
    for j = 1 : length(neur)
        
        net{i,j} = patternnet(neur(j));
        net{i,j} = train(net{i,j}, learnPoints{i}.x', learnPoints{i}.y');
        % view(net)
        y = net{i,j}(testData{i}.x');
        perf = perform(net{i,j}, testData{i}.y', y);
        classes{i,j} = vec2ind(y);
        
        confusionMatrices{i, j} = confusionmat(vec2ind(testData{i}.y'), classes{i,j});
        acc(i,j) = trace(confusionMatrices{i, j}) / length(classes{i,j});
        fprintf('BuscaTopol MLP_ %d - %d: %f\n', i, neur(j), acc(i,j));
        
        save('topologiaMLP_ToolBox','-append');
    end
end

save('topologiaMLP_ToolBox','-append');



