clear all; close all; clc;
addpath('../percetron/'); addpath('../MLM/'); addpath('../MLP/');
addpath('../multisvm/'); addpath('../bayes/'); addpath('../');

%% Load data and Pre-processing
load('../dados/haralick_hu_lbp_mide - Gray_H.mat');
dataMide.x = mide(:,1:end-1);
dataMide.y = mide(:,end);

% dataLBP.x = lbp(:,1:end-1);
% dataLBP.y = lbp(:,end);
% 
% dataHu.x = hu(:,1:end-1);
% dataHu.y = hu(:,end);
% 
% dataHaralick.x = haralick(:,1:end-1);
% dataHaralick.y = haralick(:,end);


% clear all
% dataLBP = carregaDados('iris.data', 0);



%% General Configurations
ptrn = 0.8;
numRep = 10;



%% =============== Bayes ===============
config.custo = 1 - eye(length(unique(dataMide.y)));
config.algoritmo = '';

% result = simBayes(dataHaralick, ptrn, numRep, config);
% save(sprintf('bayes_haralick - Gray_H'), 'result')
% fprintf(sprintf('bayes_haralick\n'))
% 
% result = simBayes(dataHu, ptrn, numRep, config);
% save(sprintf('bayes_hu - Gray_H'), 'result')
% fprintf(sprintf('bayes_hu\n'))
% 
% result = simBayes(dataLBP, ptrn, numRep, config);
% save(sprintf('bayes_lbp - Gray_H'), 'result')
% fprintf(sprintf('bayes_lbp\n'))
% 
result = simBayes(dataMide, ptrn, numRep, config);
save(sprintf('bayes_mide - Gray_H'), 'result')
fprintf(sprintf('bayes_mide\n'))



%% =============== SVM ===============
clear config

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

% optParam = searchParamSVM(dataHaralick, params, numRep, ptrn );
% result = simMultiSVM( dataHaralick, ptrn, numRep, optParam );
% save(sprintf('SVM - %s - Haralick - Gray_H', config.fkernel), 'result', 'config')
% fprintf('SVM - %s - Haralick', config.fkernel)
% 
% optParam = searchParamSVM(dataHu, params, numRep, ptrn );
% result = simMultiSVM( dataHu, ptrn, numRep, optParam );
% save(sprintf('SVM - %s - Hu - Gray_H', config.fkernel), 'result', 'config')
% fprintf('SVM - %s - Hu', config.fkernel)
% 
% optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
% result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
% save(sprintf('SVM - %s - LBP - Gray_H', config.fkernel), 'result', 'config')
% fprintf('SVM - %s - LBP', config.fkernel)

optParam = searchParamSVM(dataMide, params, numRep, ptrn );
result = simMultiSVM( dataMide, ptrn, numRep, optParam );
save(sprintf('SVM - %s - Mide - Gray_H', config.fkernel), 'result', 'config')
fprintf('SVM - %s - Mide', config.fkernel)


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
% optParam = searchParamSVM(dataHaralick, params, numRep, ptrn );
% result = simMultiSVM( dataHaralick, ptrn, numRep, optParam );
% save(sprintf('SVM - %s - Haralick - Gray_H', config.fkernel), 'result', 'config')
% fprintf('SVM - %s - Haralick', config.fkernel)
% 
% optParam = searchParamSVM(dataHu, params, numRep, ptrn );
% result = simMultiSVM( dataHu, ptrn, numRep, optParam );
% save(sprintf('SVM - %s - Hu - Gray_H', config.fkernel), 'result', 'config')
% fprintf('SVM - %s - Hu', config.fkernel)
% 
% optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
% result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
% save(sprintf('SVM - %s - LBP - Gray_H', config.fkernel), 'result', 'config')
% fprintf('SVM - %s - LBP', config.fkernel)
% 
optParam = searchParamSVM(dataMide, params, numRep, ptrn );
result = simMultiSVM( dataMide, ptrn, numRep, optParam );
save(sprintf('SVM - %s - Mide - Gray_H', config.fkernel), 'result', 'config')
fprintf('SVM - %s - Mide', config.fkernel)




%% =============== MLP ===============
clear config
clear params

params = [50 100:10:200 250 300];

% optParam = searchTopologyMLP(dataHaralick, params, numRep, ptrn );
% result = simMLP(dataHaralick, ptrn, numRep, optParam );
% save('MLP - Haralick - Gray_H',  'result', 'optParam')
% fprintf('MLP - Haralick')
% 
% optParam = searchTopologyMLP(dataHu, params, numRep, ptrn );
% result = simMLP(dataHu, ptrn, numRep, optParam );
% save('MLP - Hu - Gray_H',  'result', 'optParam')
% fprintf('MLP - Hu')
% 
% optParam = searchTopologyMLP(dataLBP, params, numRep, ptrn );
% result = simMLP(dataLBP, ptrn, numRep, optParam );
% save('MLP - LBP - Gray_H',  'result', 'optParam')
% fprintf('MLP - LBP')
% 
optParam = searchTopologyMLP(dataMide, params, numRep, ptrn );
result = simMLP(dataMide, ptrn, numRep, optParam );
save('MLP - Mide - Gray_H',  'result', 'optParam')
fprintf('MLP - Mide')



%% =============== LSSVM ===============
% clear config
% clear params
% % =============== LSSVM - Linear ===============
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
% save(sprintf('LSSVM - %s - Haralick - Gray_H', config.fkernel), 'result', 'config')
% fprintf('LSSVM - %s - Haralick', config.fkernel)
% 
% optParam = searchParamSVM(dataHu, params, numRep, ptrn );
% result = simMultiSVM( dataHu, ptrn, numRep, optParam );
% save(sprintf('LSSVM - %s - Hu - Gray_H', config.fkernel), 'result', 'config')
% fprintf('LSSVM - %s - Hu', config.fkernel)
% 
% optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
% result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
% save(sprintf('LSSVM - %s - LBP - Gray_H', config.fkernel), 'result', 'config')
% fprintf('LSSVM - %s - LBP', config.fkernel)
% 
% optParam = searchParamSVM(dataMide, params, numRep, ptrn );
% result = simMultiSVM( dataMide, ptrn, numRep, optParam );
% save(sprintf('LSSVM - %s - Mide - Gray_H', config.fkernel), 'result', 'config')
% fprintf('LSSVM - %s - Mide', config.fkernel)
% 
% 
% % =============== LSSVM - RBF ===============
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
% save(sprintf('LSSVM - %s - Haralick - Gray_H', config.fkernel), 'result', 'config')
% fprintf('LSSVM - %s - Haralick', config.fkernel)
% 
% optParam = searchParamSVM(dataHu, params, numRep, ptrn );
% result = simMultiSVM( dataHu, ptrn, numRep, optParam );
% save(sprintf('LSSVM - %s - Hu - Gray_H', config.fkernel), 'result', 'config')
% fprintf('LSSVM - %s - Hu', config.fkernel)
% 
% optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
% result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
% save(sprintf('LSSVM - %s - LBP - Gray_H', config.fkernel), 'result', 'config')
% fprintf('LSSVM - %s - LBP', config.fkernel)
% 
% optParam = searchParamSVM(dataMide, params, numRep, ptrn );
% result = simMultiSVM(dataMide, ptrn, numRep, optParam );
% save(sprintf('LSSVM - %s - Mide - Gray_H', config.fkernel), 'result', 'config')
% fprintf('LSSVM - %s - Mide', config.fkernel)



%% =============== Perceptron ===============
% TODO



%% =============== MLM ===============
% clear config
% 
% dataHaralick.y = full(ind2vec(dataHaralick.y'))';
% dataHu.y = full(ind2vec(dataHu.y'))';
% dataLBP.y = full(ind2vec(dataLBP.y'))';
% dataMide.y = full(ind2vec(dataMide.y'))';
% 
% config.method = ''; % lsqnonlin knn ''
% config.k = 1;
% 
% for dist = {'cityblock', '', 'mahalanobis', }
% 
%     config.distance = dist{1}; % mahalanobis cityblock ''
% 
%     result = simMLM(dataHaralick, ptrn, numRep, config);
%     save(sprintf('haralick mlm_D-%s_%.0f - Gray_H', config.distance, config.k*100),...
%         'result', 'config')
%     fprintf(sprintf('haralick mlm_D-%s_%.0f', config.distance, config.k*100))
% 
% 
%     result = simMLM(dataHu, ptrn, numRep, config);
%     save(sprintf('hu mlm_D-%s_%.0f - Gray_H', config.distance, config.k*100),...
%         'result', 'config')
%     fprintf(sprintf('hu mlm_D-%s_%.0f', config.distance, config.k*100))
% 
% 
% 
%     result = simMLM(dataLBP, ptrn, numRep, config);
%     save(sprintf('lbp mlm_D-%s_%.0f - Gray_H', config.distance, config.k*100),...
%         'result', 'config')
%     fprintf(sprintf('lbp mlm_D-%s_%.0f', config.distance, config.k*100))
% 
% 
%     result = simMLM(dataMide, ptrn, numRep, config);
%     save(sprintf('mide mlm_D-%s_%.0f - Gray_H', config.distance, config.k*100),...
%         'result', 'config')
%     fprintf(sprintf('mide mlm_D-%s_%.0f', config.distance, config.k*100))
% 
% end



%% =============== MLM-NN ===============
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
%     save(sprintf('haralick - mlm_%s_%d_D-%s_%.0f - Gray_H', config.method, config.NN,...
%         config.distance, config.k*100), 'result', 'config')
%     fprintf(sprintf('haralick - mlm_%s_%d_D-%s_%.0f\n', config.method, config.NN,...
%         config.distance, config.k*100))
% 
% 
%     result = simMLM(dataHu, ptrn, numRep, config);
%     save(sprintf('hu - mlm_%s_%d_D-%s_%.0f - Gray_H', config.method, config.NN,...
%         config.distance, config.k*100), 'result', 'config')
%     fprintf(sprintf('hu - mlm_%s_%d_D-%s_%.0f\n', config.method, config.NN,...
%         config.distance, config.k*100))
% 
% 
%     result = simMLM(dataLBP, ptrn, numRep, config);
%     save(sprintf('lbp - mlm_%s_%d_D-%s_%.0f - Gray_H', config.method, config.NN,...
%         config.distance, config.k*100), 'result', 'config')
%     fprintf(sprintf('lbp - mlm_%s_%d_D-%s_%.0f\n', config.method, config.NN,...
%         config.distance, config.k*100))
% 
% 
%     result = simMLM(dataMide, ptrn, numRep, config);
%     save(sprintf('mide - mlm_%s_%d_D-%s_%.0f - Gray_H', config.method, config.NN,...
%         config.distance, config.k*100), 'result', 'config')
%     fprintf(sprintf('mide - mlm_%s_%d_D-%s_%.0f\n', config.method, config.NN,...
%         config.distance, config.k*100))
% 
% end


