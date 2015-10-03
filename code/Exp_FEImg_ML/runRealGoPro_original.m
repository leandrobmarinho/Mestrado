clear all; close all; clc;
addpath('../Classification/percetron/'); addpath('../Classification/MLM/');
addpath('../Classification/MLP/'); addpath('../Classification/multisvm/');
addpath('../Classification/bayes/'); addpath('../utils/');


%% General configurations
% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}
conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', ...
    'lssvmRBF', 'mlm', 'mlmNN'};
conf.numRep = 100;


%% ======= Gray - Real =======
strModel = 'gray_%s_gopro_real';
% load(sprintf(sprintf('../../../data/%s', strModel), 'all'));
% mideAverage = mideAverage(:, [2 3 4 6 8 9 10 12]);
% mideSobel = mideSobel(:, [2 3 4 6 8 9 10 12]);

 
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 64;

% conf.descr = sprintf(strModel, 'mideAverage');
% evaluateData(mideAverage, conf)
% 
% conf.descr = sprintf(strModel, 'mideSobel');
% evaluateData(mideSobel, conf)

% conf.mlMethods = { 'lssvmLinear', 'svmLinear'};
% conf.descr = sprintf(strModel, 'lbp');
% evaluateData(lbp, conf)

% conf.descr = sprintf(strModel, 'hu');
% evaluateData(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evaluateData(haralick, conf)

% ---------- Central Moments ----------
% load('../../data/central_real.mat');
% conf.descr = sprintf(strModel, 'central');
% evaluateData(centralGoPro, conf)

% ---------- Statistics Moments ----------
% load('../../data/statistic_real.mat');
% conf.descr = sprintf(strModel, 'statistic');
% evaluateData(statisticGoPro, conf)



%% ======= Gray - Sim =======
% strModel = 'gray_%s_gopro_sim';
% load(sprintf(sprintf('../../../data/%s', strModel), 'all'));
% mideAverage = mideAverage(:, [2 3 4 6 8 9 10 12]);
% mideSobel = mideSobel(:, [2 3 4 6 8 9 10 12]);
 
% conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', ...
%     'lssvmRBF', 'mlm', 'mlmNN'};
% conf.descr = sprintf(strModel, 'mideAverage');
% evaluateData(mideAverage, conf)

% conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', ...
%     'lssvmRBF', 'mlm', 'mlmNN'};
% conf.descr = sprintf(strModel, 'mideSobel');
% evaluateData(mideSobel, conf)

% conf.mlMethods = {'mlp', 'mlm', 'mlmNN'};
% conf.descr = sprintf(strModel, 'lbp');
% evaluateData(lbp, conf)
% 
% conf.mlMethods = {'lssvmLinear', 'mlp', 'svmLinear', 'bayes', 'mlmNN', 'mlm'};
% conf.descr = sprintf(strModel, 'hu');
% evaluateData(hu, conf)
% 
% conf.mlMethods = {'lssvmLinear', 'mlp', 'svmLinear', 'bayes', 'mlmNN', 'mlm'};
% conf.descr = sprintf(strModel, 'haralick');
% evaluateData(haralick, conf)

% % ---------- Central Moments ----------
% load('../../data/central_sim.mat');
% conf.descr = sprintf(strModel, 'central');
% evaluateData(centralSim, conf)
% 
% % ---------- Statistics Moments ----------
% load('../../data/statistic_sim.mat');
% conf.descr = sprintf(strModel, 'statistic');
% evaluateData(statisticSim, conf)