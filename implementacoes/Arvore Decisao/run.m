close all; clear all; clc

%% Carregando os dados
data = load('../iris.data');
dataset.x = data(:, 1:4);
dataset.y = data(:, 5:7);
clear data;


%% Configurações gerais
ptrn = 0.8;


%% Separa em treinamento e teste

% Separa as classes
trainData.x = []; trainData.y = []; testData.x = []; testData.y = [];
numClass = length(dataset.y(1, :));
for i = 1 : numClass,
    classe = zeros(1, numClass);
    classe(i) = 1;
    
    % Seleciona apenas as amostras com a classe pretendida
    ind = find(classe * dataset.y');
    lengthClass = length(ind);
    
    limit = floor(ptrn*lengthClass);
    if not(isempty(ind))
        
        ind = ind(randperm(lengthClass));
        trainData.x = [trainData.x; dataset.x(ind(1:limit), :)];
        trainData.y = [trainData.y; dataset.y(ind(1:limit), :)];
        
        testData.x = [testData.x; dataset.x(ind(limit+1:end), :)];
        testData.y = [testData.y; dataset.y(ind(limit+1:end), :)];
    end
end


% Embaralha os dados
ind = randperm(length(trainData.x));
trainData.x = trainData.x(ind, :);
trainData.y = trainData.y(ind, :);

ind = randperm(length(testData.x));
testData.x = testData.x(ind, :);
testData.y = testData.y(ind, :);



%% Validando o classificador
[output] = arvoreDecisao(testData.x);

[~, index] = max(output');
[~, target] = max(testData.y');

confusionMatrices = confusionmat(target, index);
accuracy = trace(confusionMatrices) / length(testData.y)
