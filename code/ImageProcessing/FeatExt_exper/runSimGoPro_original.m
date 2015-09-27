clear all; close all; clc; p = path;
addpath('../../Classification/percetron/'); addpath('../../Classification/MLM/');
addpath('../../Classification/MLP/'); addpath('../../Classification/multisvm/');
addpath('../../Classification/bayes/'); addpath('../../utils/');

%% General configurations
% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}
conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', ...
    'lssvmRBF', 'mlm', 'mlmNN'};
conf.numRep = 4;


%% ======= Gray - Real =======
% strModel = 'gray_%s_gopro_real';
% load(sprintf(sprintf('../../../data/%s', strModel), 'all'));
% mideAverage = mideAverage(:, [2 3 4 6 8 9 10 12]);
% mideSobel = mideSobel(:, [2 3 4 6 8 9 10 12]);
% 
%  
% conf.mlMethods = {'lssvmLinear', 'mlp', 'svmLinear', 'bayes'};
% conf.descr = sprintf(strModel, 'mideAverage');
% evaluateData(mideAverage, conf)
% 
% conf.mlMethods = {'lssvmLinear', 'mlp', 'svmLinear', 'bayes'};
% conf.descr = sprintf(strModel, 'mideSobel');
% evaluateData(mideSobel, conf)
% 
% conf.mlMethods = {'mlp'};
% conf.descr = sprintf(strModel, 'lbp');
% evaluateData(lbp, conf)
% 
% conf.mlMethods = {'lssvmLinear', 'mlp', 'svmLinear'};
% conf.descr = sprintf(strModel, 'hu');
% evaluateData(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evaluateData(haralick, conf)



%% ======= Gray - Sim =======
strModel = 'gray_%s_gopro_sim';
load(sprintf(sprintf('../../../data/%s', strModel), 'all'));
mideAverage = mideAverage(:, [2 3 4 6 8 9 10 12]);
mideSobel = mideSobel(:, [2 3 4 6 8 9 10 12]);
 
% conf.mlMethods = { 'svmRBF', 'lssvmLinear', 'lssvmRBF', 'mlm', 'mlmNN'};
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 32;
% conf.descr = sprintf(strModel, 'mideAverage');
% evaluateData(mideAverage, conf)
% conf = rmfield(conf,'extraSVMLinear');


% conf.mlMethods = {'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', ...
%     'lssvmRBF', 'mlm', 'mlmNN'};
% conf.descr = sprintf(strModel, 'mideSobel');
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 64;
% evaluateData(mideSobel, conf)
% conf = rmfield(conf,'extraSVMLinear');


conf.mlMethods = {'bayes'};
conf.descr = sprintf(strModel, 'lbp');
evaluateData(lbp, conf)


% conf.mlMethods = {'lssvmLinear', 'mlp', 'svmLinear', 'bayes', 'mlmNN', 'mlm'};
% conf.descr = sprintf(strModel, 'hu');
% evaluateData(hu, conf)
% 
% 
% conf.mlMethods = {'lssvmLinear', 'mlp', 'svmLinear', 'bayes', 'mlmNN', 'mlm'};
% conf.descr = sprintf(strModel, 'haralick');
% evaluateData(haralick, conf)