function [optParam, Ecv] =  otimizadorLSSVM(dados, params, nFolds)

N = size(dados.x, 1);
if(nFolds == N),
    CVO = cvpartition(N, 'Leaveout');
else
    CVO = cvpartition(N, 'kfold', nFolds);
end

for i = 1: nFolds,
    dadosTreinX = dados.x(training(CVO, i), :);
    dadosTreinY = dados.y(training(CVO, i), :);
    dadosTesteX = dados.x(test(CVO, i), :);
    dadosTesteY = dados.y(test(CVO, i), :);
    for j = 1: length(params),
        fprintf('LSSVM %d - %d\n',i, j);
                
        my = MyLSSVM(dadosTreinX, dadosTreinY, params{j});
        my.train();
        
        output_labels = my.classify(dadosTesteX);
        
        erros(i,j) = sum(dadosTesteY ~= output_labels)/size(dadosTesteY,1);
                
    end
end

Ecv = mean(erros,1);
[~, indice] = min(Ecv);
optParam = params{indice};
end