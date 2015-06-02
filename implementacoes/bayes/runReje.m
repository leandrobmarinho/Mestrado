close all; clear all; clc; addpath('..');

name = 'column_2C';
dados = carregaDados(strcat(name, '.data'), 0);


%% Configurações gerais
ptrn = 0.75;
conf.algoritmo = 'bayesRej';

%% Buscando o melhor limiar
for i = 1 : 30
    
    [dadosTrein, dadosTeste] = embaralhaDados(dados, ptrn, 2);
%     [dadosTrein, dadosValid] = embaralhaDados(dadosTrein, ptrn, 2);
    
    [modelo] = trainBayes(dadosTrein);
    
    valores = [];
    for wr = 0.04 : 0.04 : 0.5 %0.04 : 0.04 : 0.5
        
        tabela = [];
        for t = 0.05 : 0.05 : 0.50
            
            conf.t = t;
            [Yh] = testeBayes(modelo, dadosTeste, conf);
            
            if (length(find(Yh ~= 0)) == 0)
                erro = 0;
            else
                erro = 1 - (sum(dadosTeste.y == Yh') / length(find(Yh ~= 0)));
            end
            rejeicao = length(find(Yh == 0)) / length(dadosTeste.y);
            
            chow = erro + wr*rejeicao;
            tabela = [tabela; t chow];
            
        end
        [~, pos] = min(tabela(:,2));
        
%         mean( tabela(find(tabela(:,2) == tabela(pos,2)), 1) )
%         keyboard
        
        % Validando com o melhor limiar
        conf.t = tabela(pos,1);
%         conf.t = mean( tabela(find(tabela(:,2) == tabela(pos,2)), 1) );
        [Yh] = testeBayes(modelo, dadosTeste, conf);
        
        if (length(find(Yh ~= 0)) == 0)
            erro = 0;
        else
            erro = 1 - (sum(dadosTeste.y == Yh') / length(find(Yh ~= 0)));
        end
        rejeicao = length(find(Yh == 0)) / length(dadosTeste.y);
        
        valores = [valores; wr conf.t (1-erro) rejeicao (erro + wr*rejeicao)];
    end
    valoresRod(:,:, i) = valores;
end

%% Gráfico curva de rejeição
valoresRod = mean(valoresRod(:,:,:), 3);
figure
plot(valoresRod(:,4), valoresRod(:,3), '-o')
title('Haberman', 'FontSize', 18);
ylabel('Taxa de Acerto (x 100%)', 'FontSize', 14)
xlabel('Taxa de Rejeição (x 100%)', 'FontSize', 14)

% save(name);

% resultCOMP = bayes(dataset, ptrn, numRepet, conf);