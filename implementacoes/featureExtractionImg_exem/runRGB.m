clear all; close all; clc;
addpath('../percetron/'); addpath('../MLM/'); addpath('../MLP/');
addpath('../multisvm/'); addpath('../bayes/');

%% Load data and Pre-processing
load('../dados/hu_lbp - RGB.mat');
% dataLBP.x = lbp(:,1:end-1);
% dataLBP.y = lbp(:,end);

dataHu.x = hu(:,1:end-1);
dataHu.y = hu(:,end);


% clear all
% dataLBP = carregaDados('iris.data', 0);


%% General Configurations
ptrn = 0.8;
numRep = 10;




%% Bayes
config.custo = 1 - eye(length(unique(dataHu.y)));
config.algoritmo = '';

% result = simBayes(dataLBP, ptrn, numRep, config);
% save(sprintf('bayes_LBP - RGB'), 'result')
% fprintf(sprintf('bayes_LBP\n'))

% result = simBayes(dataHu, ptrn, numRep, config);
% save(sprintf('bayes_hu - RGB'), 'result')
% fprintf(sprintf('bayes_hu\n'))


%% LSSVM
config.metodo = 'LS';
config.fkernel = 'linear';
config.options.MaxIter = 9000000;

paraC = 2.^(-5:2:9);

i = 1;
for c = paraC
    config.paraC = c;
    
    params{i} = config;
    i = i + 1;
end

% optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
% result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
% save(sprintf('LSSVM - %s - LBP - RGB', config.fkernel), 'result', 'config')
% fprintf('LSSVM - %s - LBP', config.fkernel)

optParam = searchParamSVM(dataHu, params, numRep, ptrn );
result = simMultiSVM( dataHu, ptrn, numRep, optParam );
save(sprintf('LSSVM - %s - Hu - RGB', config.fkernel), 'result', 'config')
fprintf('LSSVM - %s - Hu', config.fkernel)


%LSSVM - RBF
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
% optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
% result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
% save(sprintf('LSSVM - %s - LBP - RGB', config.fkernel), 'result', 'config')
% fprintf('LSSVM - %s - LBP', config.fkernel)

optParam = searchParamSVM(dataHu, params, numRep, ptrn );
result = simMultiSVM( dataHu, ptrn, numRep, optParam );
save(sprintf('LSSVM - %s - Hu - RGB', config.fkernel), 'result', 'config')
fprintf('LSSVM - %s - Hu', config.fkernel)



%% MLM-NN
clear config

% dataHu.y = full(ind2vec(dataHu.y'))';
dataLBP.y = full(ind2vec(dataLBP.y'))';

config.method = ''; % lsqnonlin knn ''
config.k = 1;

for dist = {'cityblock', '', 'mahalanobis', }

    config.distance = dist{1}; % mahalanobis cityblock ''

%     result = simMLM(dataLBP, ptrn, numRep, config);
%     save(sprintf('mlm_D-%s_%.0f - RGB', config.distance, config.k*100), 'result', 'config')
%     fprintf(sprintf('mlm_D-%s_%.0f', config.distance, config.k*100))


    result = simMLM(dataHu, ptrn, numRep, config);
    save(sprintf('mlm_D-%s_%.0f - RGB',config.distance, config.k*100), 'result', 'config')
    fprintf(sprintf('mlm_D-%s_%.0f', config.distance, config.k*100))



end


%% MLM-NN
clear config

config.method = 'knn'; % lsqnonlin knn ''
config.k = 1;
config.NN = 9;

for dist = {'cityblock', '', 'mahalanobis', }

    config.distance = dist{1}; % mahalanobis cityblock ''

%     result = simMLM(dataLBP, ptrn, numRep, config);
%     save(sprintf('mlm_%s_%d_D-%s_%.0f - RGB', config.method, config.NN, config.distance, config.k*100), 'result', 'config')
%     fprintf(sprintf('mlm_%s_%d_D-%s_%.0f\n', config.method, config.NN, config.distance, config.k*100))


    result = simMLM(dataHu, ptrn, numRep, config);
    save(sprintf('mlm_%s_%d_D-%s_%.0f - RGB', config.method, config.NN, config.distance, config.k*100), 'result', 'config')
    fprintf(sprintf('mlm_%s_%d_D-%s_%.0f\n', config.method, config.NN, config.distance, config.k*100))

end


%% MLP
clear config
params = [50 100:10:200 250 300];

% optParam = searchTopologyMLP(dataLBP, params, numRep, ptrn );
% result = simMLP(dataLBP, ptrn, numRep, optParam );
% save('MLP - LBP - RGB',  'result', 'optParam')
% fprintf('MLP - LBP')

optParam = searchTopologyMLP(dataHu, params, numRep, ptrn );
result = simMLP(dataHu, ptrn, numRep, optParam );
save('MLP - Hu - RGB',  'result', 'optParam')
fprintf('MLP - Hu')



%% SVM
clear config
clear params
dataLBP.y = vec2ind(dataLBP.y')';
dataHu.y = vec2ind(dataHu.y')';


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

% optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
% result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
% save(sprintf('SVM - %s - LBP - RGB', config.fkernel), 'result', 'config')
% fprintf('SVM - %s - LBP', config.fkernel)

optParam = searchParamSVM(dataHu, params, numRep, ptrn );
result = simMultiSVM( dataHu, ptrn, numRep, optParam );
save(sprintf('SVM - %s - Hu - RGB', config.fkernel), 'result', 'config')
fprintf('SVM - %s - Hu', config.fkernel)


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
% optParam = searchParamSVM(dataLBP, params, numRep, ptrn );
% result = simMultiSVM( dataLBP, ptrn, numRep, optParam );
% save(sprintf('SVM - %s - LBP - RGB', config.fkernel), 'result', 'config')
% fprintf('SVM - %s - LBP', config.fkernel)

optParam = searchParamSVM(dataHu, params, numRep, ptrn );
result = simMultiSVM( dataHu, ptrn, numRep, optParam );
save(sprintf('SVM - %s - Hu - RGB', config.fkernel), 'result', 'config')
fprintf('SVM - %s - Hu', config.fkernel)