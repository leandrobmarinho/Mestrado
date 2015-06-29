close all; clear all; clc; addpath('..');

%% Pré-processamento
dados = carregaDados('column_2C.data', 4);

%% Configurações gerais
ptrn = 0.8;
numRodadas = 10;
numFolds = 10;


%% Criando as combinações de parâmetros para a validação cruzada

paraC = ceil(0.1 * ptrn * size(dados.y, 1)) - 4 : ceil(0.1 * ptrn * size(dados.y, 1)) + 4;
i = 1;
for sigma = 10 : 16
    
    for c = paraC
        params{1,i} = c;
        params{2,i} = 'rbf';
        params{3,i} = sigma;
        i = i + 1;
    end
end

for c = paraC
    params{1,i} = c;
    params{2,i} = 'linear';
    i = i + 1;
end


%% Avaliando o método
for i = 1 : numRodadas,
    %% Embaralhando os dados
    [dadosTrein, dadosTeste] = embaralhaDados(dados, ptrn, 2);
    
    
    %% Validação cruzada
    fprintf('Cross validation and grid search...\n')
    [optParams{i}, Ecv{i}] = otimizadorSVM(dadosTrein, params, numFolds);
    
    
    %% Treinamento do SVM
    fprintf('Treinando o SVM...\nRodada %d\n', i)
    
    c = optParams{i}{1,1};
    fkernel = optParams{i}{2,1};
    if (strcmp('rbf', fkernel) == 1)
        sigma = optParams{i}{3,1};
        
        modelo{i} = svmtrain(dadosTrein.x, dadosTrein.y,'kernel_function',...
            fkernel,'rbf_sigma',sigma,'boxconstraint',c,...
            'method','QP','kernelcachelimit',15000);
    else
        modelo{i} = svmtrain(dadosTrein.x, dadosTrein.y,'kernel_function',...
            fkernel,'boxconstraint',c,'method','QP','kernelcachelimit',15000);
    end
        
    %% Testando o SVM
    fprintf('Testando o SVM...\nRodada %d\n\n', i)
    Yh = svmclassify(modelo{i}, dadosTeste.x);

%     [Yh] = testeSOM_KNN(modelo, dadosTeste);
    
    % Matriz de confusao e acurácia    
    matrizesConf{i} = confusionmat(dadosTeste.y, Yh);
    acuracia(i) = trace(matrizesConf{i}) / size(Yh,1);
end

mediaAcc = mean(acuracia);

% Procurando a matriz de confusão mais próxima da acurácia média
[~, posicoes] = sort( abs ( mediaAcc - acuracia ) );


desvPadr = std(acuracia);
matrizConfMedia = matrizesConf{posicoes(1)};
clear Yh dados dadosTeste dadosTrein i c paraC posicoes sigma fkernel