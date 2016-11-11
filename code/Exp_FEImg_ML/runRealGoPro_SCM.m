clear; close all; clc;
addpath('../Classification/MLP/'); addpath('../Classification/multisvm/');
addpath('../Classification/bayes/'); addpath('../utils/');


%% General configurations
% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}
conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', 'lssvmRBF'};
conf.numRep = 10;
conf.mlMethods = { 'svmLinear'};


%% ======= Real SCM =======
strModel = 'scm_gopro_real';
load(sprintf('../../data/%s', strModel));

conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 8192;

conf.descr = sprintf(strModel, 'scm');
evaluate_ml(dataSCM, conf)


