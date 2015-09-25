function [ resultado ] = buscaRBFsom( dadosTrein, dadosTeste, modelos, gammas )
%BUSCATOPOLOGIASOM Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : size(modelos,1),
    learnPoints = dadosTrein{1,i};
    testData = dadosTeste{1,i};
    
    for j = 1: size(modelos,2),

        for k = 1 : length(gammas)
            rede.gamma = gammas(k);
            rede.W = modelos{i,j}.W;
            [modeloRBF{i,j,k}] = treinoRBF(learnPoints, rede);
            [Yh] = testeRBF(modeloRBF{i,j,k}, testData);
                        
            % Calculando acc
            [~, target] = max(testData.y');
            confusionMatrices{i, j, k} = confusionmat(target, Yh);
            txAcert(i, j, k) = trace(confusionMatrices{i,j, k}) / length(target);
            fprintf('%d %d %d Acc: %f\n', i, j, k, txAcert(i, j, k));
        end
    end
end

resultado.matrizesConfuzao = confusionMatrices;
resultado.modelosRBF = modeloRBF;
resultado.acuracias = txAcert;

end

