clear; close all; clc;
addpath('../Classification/percetron/'); addpath('../Classification/MLM/');
addpath('../Classification/MLP/'); addpath('../Classification/multisvm/');
addpath('../Classification/bayes/'); addpath('../utils/');


% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}
%% General configurations
conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', ...
    'lssvmRBF', 'mlm', 'mlmNN'};
conf.mlMethods = {'svmLinear', 'svmRBF', 'lssvmLinear', 'lssvmRBF'};
conf.numRep = 10;
conf.routes{1} = [8 7 3 4];
conf.routes{2} = [1 6 10 9];
conf.routes{3} = [5 2 11 12];
conf.routes{4} = [5 1 6 9 10];
conf.routes{5} = [8 7 2 11 12];
conf.routes{6} = [13 15 3 4 5 1];
conf.routes{7} = [8 7 3 2 11 12];
conf.routes{8} = [9 8 7 2 11 15 3];
conf.routes{9} = [2 11 14 13 15 3];
conf.routes{10} = [12 11 15 3 4 5 1 6 10];

%% ------------------ REAL ------------------
strModel = 'gray_%s_omni_real';
load(sprintf(sprintf('../../data/%s', strModel), 'all'));


% % ---------- LBP ----------
conf.descr = sprintf(strModel, 'lbp');
% evaluate_ml_route(lbp, conf)


% ---------- Central Moments ----------
conf.descr = sprintf(strModel, 'central');
% evaluate_ml_route(central, conf)



% ---------- Statistics Moments ----------
conf.descr = sprintf(strModel, 'statistic');
evaluate_ml_route(statistic, conf)



% % ---------- Hu Moments ----------
conf.descr = sprintf(strModel, 'hu');
evaluate_ml_route(hu, conf)



% % ---------- Haralick ----------
conf.descr = sprintf(strModel, 'haralick');
evaluate_ml_route(haralick, conf)