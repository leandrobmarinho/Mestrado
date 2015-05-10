close all; clear all; clc; addpath('..');

dados = carregaDados('column_2C.data', 0);


%% Configurações gerais
ptrn = 0.8;
conf.algoritmo = 'bayesRej';

%% Buscando o melhor limiar
for i = 1 : 10
    
    [dadosTrein, dadosValid] = embaralhaDados(dados, ptrn, 2);
    [dadosTrein, dadosTeste] = embaralhaDados(dadosTrein, ptrn, 2);
    
    [modelo] = trainBayes(dadosTrein);
    
    limiares = [];
    for wr = 0.04 : 0.04 : 0.5
        
        tabela = [];
        for t = 0.05 : 0.05 : 0.5
            
            conf.t = t;
            [Yh] = testeBayes(modelo, dadosTeste, conf);
            
            erro = 1 - (sum(dadosTeste.y == Yh') / length(find(Yh ~= 0)));
            rejeicao = length(find(Yh == 0)) / length(dadosTeste.y);
            
            chow = erro + wr*rejeicao;
            tabela = [tabela; t chow];
            
        end
        [~, pos] = min(tabela(:,2));
        
        % Validando com o melhor limiar
        conf.t = tabela(pos,1);
        [Yh] = testeBayes(modelo, dadosValid, conf);
        erro = 1 - (sum(dadosValid.y == Yh') / length(find(Yh ~= 0)));
        rejeicao = length(find(Yh == 0)) / length(dadosValid.y);
        
        limiares = [limiares; wr tabela(pos,1) (1-erro) rejeicao (erro + wr*rejeicao)];
    end
    valore(:,:, i) = limiares;
end

%% Gráfico curva de rejeição
figure
plot(limiares(:,4), limiares(:,3), '-o')

% resultCOMP = bayes(dataset, ptrn, numRepet, conf);