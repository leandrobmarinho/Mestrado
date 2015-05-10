function [ resultado ] = buscaTopologiaSOMKNN( dados, params, conf )
%BUSCATOPOLOGIASOM Summary of this function goes here
%   Detailed explanation goes here

save('topologiaSOMKNN');
errosTrein = zeros(conf.treinos, length(params));
errosTeste = zeros(conf.treinos, length(params));
for i = 1 : conf.treinos,
    %% Embaralhando os dados
    [learnPoints{i}, testData{i}] = embaralhaDados(dados, conf.ptrn, 2);
    
    for j = 1: length(params),
        fprintf('Busca Topologia SOM-KNN. %d - %d.\n', i, j);

        tic
        [modelo{i,j}, errosQuantTrein{i,j}] = trainSOM_KNN(learnPoints{i}, params{j});
        errosTrein(i, j) = mean(errosQuantTrein{i,j});
        [Yh] = testeSOM_KNN(modelo{i,j}, testData{i});
        
        % Calculando erro
        confusionMatrices{i, j} = confusionmat(testData{i}.y, Yh);
        errosTeste(i, j) = 1 - trace(confusionMatrices{i,j}) / length(find(Yh ~= 0));
        fprintf('Acc: %f\n', 1 - errosTeste(i, j));
        
        save('topologiaSOMKNN','-append');
        toc
    end
end

if conf.treinos == 1
    resultado.varianciaTrein = zeros(1, size(errosTrein,2));
    resultado.varianciaTeste = zeros(1, size(errosTeste,2));
else
    resultado.varianciaTrein = var(errosTrein, 1);
    resultado.varianciaTeste = var(errosTeste, 1);
end
resultado.mediaTrein = mean(errosTrein, 1);
resultado.mediaTeste = mean(errosTeste, 1);

% save('topologiaSOMKNN','-append');

figure
plot(1:1:size(errosTrein,2), resultado.mediaTrein, '--ob');
hold on
plot(1:1:size(errosTrein,2), resultado.varianciaTrein, '--or');
legend('Media ErrTrein', 'Var ErrTrein', 'Location', 'northoutside',...
    'Orientation','horizontal');

figure
plot(1:1:size(errosTeste,2), resultado.mediaTeste, '-om');
hold on
plot(1:1:size(errosTeste,2), resultado.varianciaTeste, '-ok');
legend('Media ErrTeste', 'Var ErrTeste', 'Location', 'northoutside',...
    'Orientation','horizontal');

end

