clear all; close all; clc;
addpath('../percetron/'); addpath('../MLM/'); addpath('../MLP/');
addpath('../multisvm/'); addpath('../bayes/');

%% Load data and Pre-processing
load('../dados/haralick_hu_lbp - HSV.mat');
dataLBP.x = lbp(:,1:end-1);
dataLBP.y = lbp(:,end);

dataHu.x = hu(:,1:end-1);
dataHu.y = hu(:,end);

dataHaralick.x = haralick(:,1:end-1);
dataHaralick.y = haralick(:,end);


% clear all
% dataLBP = carregaDados('iris.data', 0);


%% General Configurations
ptrn = 0.8;
numRep = 10;




% %% Bayes
% config.custo = 1 - eye(length(unique(dataLBP.y)));
% config.algoritmo = '';
% 
% result = simBayes(dataHaralick, ptrn, numRep, config);
% save(sprintf('1 - bayes_haralick'), 'result')
% fprintf(sprintf('1 - bayes_haralick\n'))
% 
% result = simBayes(dataHu, ptrn, numRep, config);
% save(sprintf('2 - bayes_hu'), 'result')
% fprintf(sprintf('2 - bayes_hu\n'))
% 
% result = simBayes(dataLBP, ptrn, numRep, config);
% save(sprintf('3 - bayes_lbp'), 'result')
% fprintf(sprintf('3 - bayes_lbp\n'))
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
% optParam = searchParamSVM(dataHaralick, params, numRep, ptrn );
% result = simMultiSVM( dataHaralick, ptrn, numRep, optParam );
% save(sprintf('4 - LSSVM - %s - Haralick', config.fkernel), 'result', 'config')
% fprintf('4 - LSSVM - %s - Haralick', config.fkernel)
% 
% optParam = searchParamSVM(dataHu, params, numRep, ptrn );
% result = simMultiSVM( dataHu, ptrn, numRep, optParam );
% save(sprintf('5 - LSSVM - %s - Hu', config.fkernel), 'result', 'config')
% fprintf('5 - LSSVM - %s - Hu', config.fkernel)
% 
% optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
% result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
% save(sprintf('6 - LSSVM - %s - LBP', config.fkernel), 'result', 'config')
% fprintf('6 - LSSVM - %s - LBP', config.fkernel)
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
% optParam = searchParamSVM(dataHaralick, params, numRep, ptrn );
% result = simMultiSVM( dataHaralick, ptrn, numRep, optParam );
% save(sprintf('7 - LSSVM - %s - Haralick', config.fkernel), 'result', 'config')
% fprintf('7 - LSSVM - %s - Haralick', config.fkernel)
% 
% optParam = searchParamSVM(dataHu, params, numRep, ptrn );
% result = simMultiSVM( dataHu, ptrn, numRep, optParam );
% save(sprintf('8 - LSSVM - %s - Hu', config.fkernel), 'result', 'config')
% fprintf('8 - LSSVM - %s - Hu', config.fkernel)
% 
% optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
% result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
% save(sprintf('9 - LSSVM - %s - LBP', config.fkernel), 'result', 'config')
% fprintf('9 - LSSVM - %s - LBP', config.fkernel)
% 
% 
% 
% 
% % %% MLM-NN
% clear config
% i = 10;
% 
% dataHaralick.y = full(ind2vec(dataHaralick.y'))';
% dataHu.y = full(ind2vec(dataHu.y'))';
% dataLBP.y = full(ind2vec(dataLBP.y'))';
% 
% config.method = ''; % lsqnonlin knn ''
% config.k = 1;
% 
% for dist = {'cityblock', '', 'mahalanobis', }
% 
%     config.distance = dist{1}; % mahalanobis cityblock ''
% 
%     result = simMLM(dataHaralick, ptrn, numRep, config);
%     save(sprintf('%d - mlm_D-%s_%.0f', i, config.distance, config.k*100),...
%         'result', 'config')
%     fprintf(sprintf('%d - mlm_D-%s_%.0f', i, config.distance, config.k*100))
% 
% 
%     result = simMLM(dataHu, ptrn, numRep, config);
%     save(sprintf('%d - mlm_D-%s_%.0f', i+1, config.distance, config.k*100),...
%         'result', 'config')
%     fprintf(sprintf('%d - mlm_D-%s_%.0f', i+1, config.distance, config.k*100))
% 
% 
% 
%     result = simMLM(dataLBP, ptrn, numRep, config);
%     save(sprintf('%d - mlm_D-%s_%.0f', i+2, config.distance, config.k*100),...
%         'result', 'config')
%     fprintf(sprintf('%d - mlm_D-%s_%.0f', i+2, config.distance, config.k*100))
% 
% 
%     i = i + 3;
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
%     result = simMLM(dataHaralick, ptrn, numRep, config);
%     save(sprintf('%d - mlm_%s_%d_D-%s_%.0f', i, config.method, config.NN,...
%         config.distance, config.k*100), 'result', 'config')
%     fprintf(sprintf('%d - mlm_%s_%d_D-%s_%.0f\n', i, config.method, config.NN,...
%         config.distance, config.k*100))
% 
% 
%     result = simMLM(dataHu, ptrn, numRep, config);
%     save(sprintf('%d - mlm_%s_%d_D-%s_%.0f', i+1, config.method, config.NN,...
%         config.distance, config.k*100), 'result', 'config')
%     fprintf(sprintf('%d - mlm_%s_%d_D-%s_%.0f\n', i, config.method, config.NN,...
%         config.distance, config.k*100))
% 
% 
%     result = simMLM(dataLBP, ptrn, numRep, config);
%     save(sprintf('%d - mlm_%s_%d_D-%s_%.0f', i+2, config.method, config.NN,...
%         config.distance, config.k*100), 'result', 'config')
%     fprintf(sprintf('%d - mlm_%s_%d_D-%s_%.0f\n', i, config.method, config.NN,...
%         config.distance, config.k*100))
% 
%     i = i + 3;
% end
% 
% 
% %% MLP
% clear config
% params = [50 100:10:200 250 300];
% 
% optParam = searchTopologyMLP(dataHaralick, params, numRep, ptrn );
% result = simMLP(dataHaralick, ptrn, numRep, optParam );
% save('28 - MLP - Haralick',  'result', 'optParam')
% fprintf('28 - MLP - Haralick')
% 
% optParam = searchTopologyMLP(dataHu, params, numRep, ptrn );
% result = simMLP(dataHu, ptrn, numRep, optParam );
% save('29 - MLP - Hu',  'result', 'optParam')
% fprintf('29 - MLP - Hu')
% 
% optParam = searchTopologyMLP(dataLBP, params, numRep, ptrn );
% result = simMLP(dataLBP, ptrn, numRep, optParam );
% save('30 - MLP - LBP',  'result', 'optParam')
% fprintf('30 - MLP - LBP')
% 
% 
% %% SVM
% clear config
% dataHaralick.y = vec2ind(dataHaralick.y')';
% dataHu.y = vec2ind(dataHu.y')';
% dataLBP.y = vec2ind(dataLBP.y')';


config.metodo = 'SMO';
config.fkernel = 'linear';
config.options.MaxIter = 9000000;

paraC = 2.^(-5:2:9);
paraC = [2 4];

i = 1;
for c = paraC
    config.paraC = c;
    
    params{i} = config;
    i = i + 1;
end

optParam = searchParamSVM(dataHaralick, params, numRep, ptrn );
result = simMultiSVM( dataHaralick, ptrn, numRep, optParam );
save(sprintf('31 - SVM - %s - Haralick', config.fkernel), 'result', 'config')
fprintf('31 - SVM - %s - Haralick', config.fkernel)

optParam = searchParamSVM(dataHu, params, numRep, ptrn );
result = simMultiSVM( dataHu, ptrn, numRep, optParam );
save(sprintf('32 - SVM - %s - Hu', config.fkernel), 'result', 'config')
fprintf('32 - SVM - %s - Hu', config.fkernel)

optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
save(sprintf('33 - LSSVM - %s - LBP', config.fkernel), 'result', 'config')
fprintf('33 - SVM - %s - LBP', config.fkernel)

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
optParam = searchParamSVM(dataHaralick, params, numRep, ptrn );
result = simMultiSVM( dataHaralick, ptrn, numRep, optParam );
save(sprintf('34 - SVM - %s - Haralick', config.fkernel), 'result', 'config')
fprintf('34 - SVM - %s - Haralick', config.fkernel)

optParam = searchParamSVM(dataHu, params, numRep, ptrn );
result = simMultiSVM( dataHu, ptrn, numRep, optParam );
save(sprintf('35 - SVM - %s - Hu', config.fkernel), 'result', 'config')
fprintf('35 - SVM - %s - Hu', config.fkernel)

optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
save(sprintf('36 - SVM - %s - LBP', config.fkernel), 'result', 'config')
fprintf('36 - SVM - %s - LBP', config.fkernel)