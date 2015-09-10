function [ neuCO, Ecv ] = searchTopologyMLP( dados, params, num, ptrn )
%SEARCHTOPOLOGYMLP Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : num,
    %% Embaralhando os dados
    [learnPoints, testData] = embaralhaDados(dados, ptrn, 2);
    
    for j = 1: length(params),
        
        fprintf('Busca Topologia MLP. %d - %d.\n', i, j);        
        net = patternnet(params(j));
        net.trainParam.showWindow = 0;        
        net = train(net, learnPoints.x', learnPoints.y');
        
        
        Y = net(testData.x');
        classes = vec2ind(Y);
        confusionMatrices{i, j} = confusionmat(vec2ind(testData.y'), classes);
        acc(i,j) = trace(confusionMatrices{i, j}) / length(classes);
        
        fprintf('ACC: %f\n',  acc(i, j));
        
    end
end

Ecv = mean(acc,1);
[~, indice] = max(Ecv);
neuCO = params(indice);

end

