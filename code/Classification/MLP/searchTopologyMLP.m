function [ neuCO, Ecv ] = searchTopologyMLP( dados, params, num, ptrn )
%SEARCHTOPOLOGYMLP Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : num,
    %% Embaralhando os dados
    [learnPoints, testData] = embaralhaDados(dados, ptrn, 2);
    
    fprintf('Busca Topologia MLP. %d.\n', i);
    for j = 1: length(params),
        net = patternnet(params(j));
        net.trainFcn =  'trainlm';
%         net.trainFcn =  'traingd';
        net.trainParam.showWindow = 0;
        net.performFcn = 'mse';
        net = train(net, learnPoints.x', learnPoints.y');
        
        
        Y = net(testData.x');
        classes = vec2ind(Y);
        confusionMatrices{i, j} = confusionmat(vec2ind(testData.y'), classes);
        acc(i,j) = trace(confusionMatrices{i, j}) / length(classes);
        
        fprintf('ACC: %f %d\n',  acc(i, j), params(j));
        
    end
end

Ecv = mean(acc,1);
[~, indice] = max(Ecv);
neuCO = params(indice);

end

