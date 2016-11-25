clear; close all; clc;
addpath('../Classification/MLP/'); addpath('../Classification/multisvm/');
addpath('../Classification/bayes/'); addpath('../utils/');


%% General configurations
% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}
conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', 'lssvmRBF'};
conf.numRep = 10;

%% ======= Real SCM =======
% strModel = 'scm_gopro_real';
strModel = 'scm_%s_gopro_real';
load(sprintf(sprintf('../../data/%s', strModel), 'others'));
% load(sprintf('../../data/%s', strModel));


conf.descr = sprintf(strModel, 'l');
evaluate_ml(dataSCM_l, conf)


conf.descr = sprintf(strModel, 'a');
evaluate_ml(dataSCM_a, conf)


conf.descr = sprintf(strModel, 's');
evaluate_ml(dataSCM_s, conf)
