function [optParam, Ecv] =  otimizadorSVM(data, param, nFolds)

N = size(data.x, 1);
if(nFolds == N),
    CVO = cvpartition(N, 'Leaveout');
else
    CVO = cvpartition(N, 'kfold', nFolds);
end

erros = zeros(nFolds, length(param));
for i = 1: nFolds,
    dadosTreinX = data.x(training(CVO, i), :);
    dadosTreinY = data.y(training(CVO, i), :);
    dadosTesteX = data.x(test(CVO, i), :);
    dadosTesteY = data.y(test(CVO, i), :);
    for j = 1: size(param,2),
        fprintf('SVM %d - %d\n',i, j);
        
        paraC = param{1,j};
        fkernel = param{2,j};
        metodo = param{end,j};
        options.MaxIter = 1000000;

        if (strcmp('rbf', fkernel) == 1)
            sigma = param{3,j};
            
            modelo = svmtrain(dadosTreinX, dadosTreinY,'kernel_function',...
                fkernel,'rbf_sigma',sigma,'boxconstraint',paraC,...
                'method',metodo,'kernelcachelimit',15000, 'Options', options);
        else
            modelo = svmtrain(dadosTreinX, dadosTreinY,'kernel_function',...
                fkernel,'boxconstraint',paraC,'method',metodo,...
                'kernelcachelimit',15000, 'Options', options);
        end
        
        Yh = svmclassify(modelo, dadosTesteX);
        erros(i,j) = sum(dadosTesteY ~= Yh)/size(dadosTesteY,1);
                
    end
end

Ecv = mean(erros,1);
[~, indice] = min(Ecv);
optParam = param(:, indice);
end