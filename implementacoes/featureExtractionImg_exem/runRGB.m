clear all; close all; clc;
addpath('../percetron/'); addpath('../MLM/'); addpath('../MLP/');
addpath('../multisvm/'); addpath('../bayes/');

%% Load data and Pre-processing
load('../dados/hu_lbp - RGB.mat');
dataLBP.x = lbp(:,1:end-1);dataLBP.x = normalizaDados( dataLBP.x, 1 );
dataLBP.y = lbp(:,end);

% dataHu.x = hu(:,1:end-1);dataHu.x = normalizaDados( dataHu.x, 1 );
% dataHu.y = hu(:,end);


% clear all
% dataLBP = carregaDados('iris.data', 0);


%% General Configurations
ptrn = 0.8;
numRep = 10;



% 
% %% Bayes
% config.custo = 1 - eye(length(unique(dataLBP.y)));
% config.algoritmo = '';
% 
% result = simBayes(dataLBP, ptrn, numRep, config);
% save(sprintf('1 - bayes_LBP - RGB'), 'result')
% fprintf(sprintf('1 - bayes_LBP\n'))
% 
% % result = simBayes(dataHu, ptrn, numRep, config);
% % save(sprintf('2 - bayes_hu - RGB'), 'result')
% % fprintf(sprintf('2 - bayes_hu\n'))
% 
% 
% %% LSSVM
% config.metodo = 'LS';
% config.fkernel = 'linear';
% config.options.MaxIter = 9000000;
% 
% paraC = 2.^(-5:2:9);
% 
% i = 1;
% for c = paraC
%     config.paraC = c;
%     
%     params{i} = config;
%     i = i + 1;
% end
% 
% optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
% result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
% save(sprintf('2 - LSSVM - %s - LBP - RGB', config.fkernel), 'result', 'config')
% fprintf('2 - LSSVM - %s - LBP', config.fkernel)
% 
% % optParam = searchParamSVM(dataHu, params, numRep, ptrn );
% % result = simMultiSVM( dataHu, ptrn, numRep, optParam );
% % save(sprintf('4 - LSSVM - %s - Hu - RGB', config.fkernel), 'result', 'config')
% % fprintf('4 - LSSVM - %s - Hu', config.fkernel)
% 
% 
% %LSSVM - RBF
% clear params
% config.fkernel = 'rbf';
% i = 1;
% for sigma = 2.^(-10:5)
%     
%     for c = paraC
%         config.paraC = c;
%         config.sigma = sigma;
%         
%         params{i} = config;
%         i = i + 1;
%     end
% end
% optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
% result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
% save(sprintf('3 - LSSVM - %s - LBP - RGB', config.fkernel), 'result', 'config')
% fprintf('3 - LSSVM - %s - LBP', config.fkernel)
% 
% % optParam = searchParamSVM(dataHu, params, numRep, ptrn );
% % result = simMultiSVM( dataHu, ptrn, numRep, optParam );
% % save(sprintf('6 - LSSVM - %s - Hu - RGB', config.fkernel), 'result', 'config')
% % fprintf('6 - LSSVM - %s - Hu', config.fkernel)
% 
% 
% 
% %% MLM-NN
% clear config
% i = 4;
% 
% % dataHu.y = full(ind2vec(dataHu.y'))';
% dataLBP.y = full(ind2vec(dataLBP.y'))';
% 
% config.method = ''; % lsqnonlin knn ''
% config.k = 1;
% 
% for dist = {'cityblock', '', 'mahalanobis', }
% 
%     config.distance = dist{1}; % mahalanobis cityblock ''
% 
%     result = simMLM(dataLBP, ptrn, numRep, config);
%     save(sprintf('%d - mlm_D-%s_%.0f - RGB', i, config.distance, config.k*100),...
%         'result', 'config')
%     fprintf(sprintf('%d - mlm_D-%s_%.0f', i, config.distance, config.k*100))
% 
% 
% %     result = simMLM(dataHu, ptrn, numRep, config);
% %     save(sprintf('%d - mlm_D-%s_%.0f - RGB', i+1, config.distance, config.k*100),...
% %         'result', 'config')
% %     fprintf(sprintf('%d - mlm_D-%s_%.0f', i+1, config.distance, config.k*100))
% 
% 
% 
%     i = i + 1;
% end
% 
% 
% %% MLM-NN
% clear config
% 
% config.method = 'knn'; % lsqnonlin knn ''
% config.k = 1;
% config.NN = 9;
% 
% for dist = {'cityblock', '', 'mahalanobis', }
% 
%     config.distance = dist{1}; % mahalanobis cityblock ''
% 
%     result = simMLM(dataLBP, ptrn, numRep, config);
%     save(sprintf('%d - mlm_%s_%d_D-%s_%.0f - RGB', i, config.method, config.NN,...
%         config.distance, config.k*100), 'result', 'config')
%     fprintf(sprintf('%d - mlm_%s_%d_D-%s_%.0f\n', i, config.method, config.NN,...
%         config.distance, config.k*100))
% 
% 
% %     result = simMLM(dataHu, ptrn, numRep, config);
% %     save(sprintf('%d - mlm_%s_%d_D-%s_%.0f - RGB', i+1, config.method, config.NN,...
% %         config.distance, config.k*100), 'result', 'config')
% %     fprintf(sprintf('%d - mlm_%s_%d_D-%s_%.0f\n', i, config.method, config.NN,...
% %         config.distance, config.k*100))
% 
% 
%     i = i + 2;
% end
% 
% 
% %% MLP
% clear config
% params = [50 100:10:200 250 300];
% 
% optParam = searchTopologyMLP(dataLBP, params, numRep, ptrn );
% result = simMLP(dataLBP, ptrn, numRep, optParam );
% save('10 - MLP - LBP - RGB',  'result', 'optParam')
% fprintf('10 - MLP - LBP')
% 
% % optParam = searchTopologyMLP(dataHu, params, numRep, ptrn );
% % result = simMLP(dataHu, ptrn, numRep, optParam );
% % save('20 - MLP - Hu - RGB',  'result', 'optParam')
% % fprintf('20 - MLP - Hu')
% 


%% SVM
clear config
clear params
% dataLBP.y = vec2ind(dataLBP.y')';
% dataHu.y = vec2ind(dataHu.y')';


config.metodo = 'SMO';
config.fkernel = 'linear';
config.options.MaxIter = 9000000;

paraC = 2.^(-5:2:9);

i = 1;
for c = paraC
    config.paraC = c;
    
    params{i} = config;
    i = i + 1;
end

optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
save(sprintf('11 - SVM - %s - LBP - RGB', config.fkernel), 'result', 'config')
fprintf('11 - SVM - %s - LBP', config.fkernel)

% optParam = searchParamSVM(dataHu, params, numRep, ptrn );
% result = simMultiSVM( dataHu, ptrn, numRep, optParam );
% save(sprintf('22 - SVM - %s - Hu - RGB', config.fkernel), 'result', 'config')
% fprintf('22 - SVM - %s - Hu', config.fkernel)


clear params
config.fkernel = 'rbf';
i = 1;
for sigma = 2.^(-10:5)
    
    for c = paraC
        config.paraC = c;
        config.sigma = sigma;
        
        params{i} = config;
        i = i + 1;
    end
end
optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
save(sprintf('12 - SVM - %s - LBP - RGB', config.fkernel), 'result', 'config')
fprintf('12 - SVM - %s - LBP', config.fkernel)

% optParam = searchParamSVM(dataHu, params, numRep, ptrn );
% result = simMultiSVM( dataHu, ptrn, numRep, optParam );
% save(sprintf('24 - SVM - %s - Hu - RGB', config.fkernel), 'result', 'config')
% fprintf('24 - SVM - %s - Hu', config.fkernel)