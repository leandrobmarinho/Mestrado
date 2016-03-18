clear; close all; clc;
addpath('../Classification/percetron/'); addpath('../Classification/MLM/');
addpath('../Classification/MLP/'); addpath('../Classification/multisvm/');
addpath('../Classification/bayes/'); addpath('../utils/');


%% General configurations
% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}
conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', ...
    'lssvmRBF', 'mlm', 'mlmNN'};
conf.numRep = 10;


%% ------------------ Sim ------------------
strModel = 'gray_%s_omni_sim';
load(sprintf(sprintf('../../data/%s', strModel), 'all'));


% % ---------- LBP ----------
% conf.descr = sprintf(strModel, 'lbp');
% evaluate_ml(lbp, conf)


% % ---------- Central Moments ----------
% conf.descr = sprintf(strModel, 'central');
% evaluate_ml(central, conf)


% %---------- Statistics Moments ----------
% conf.descr = sprintf(strModel, 'statistic');
% evaluate_ml(statistic, conf)


% ---------- Hu Moments ----------
conf.descr = sprintf(strModel, 'hu');
evaluate_ml(hu, conf)


% ---------- Haralick ----------
conf.descr = sprintf(strModel, 'haralick');
evaluate_ml(haralick, conf)