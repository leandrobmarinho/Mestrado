clear all; close all; clc;
addpath('../Classification/percetron/'); addpath('../Classification/MLM/');
addpath('../Classification/MLP/'); addpath('../Classification/multisvm/');
addpath('../Classification/bayes/'); addpath('../utils/');


%% General configurations
% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}
conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', ...
    'lssvmRBF', 'mlm', 'mlmNN'};
conf.numRep = 5;


%% Real
strModel = 'gray_%s_gopro_real';
load(sprintf(sprintf('../../data/%s', strModel), 'all'));
% mideAverage = mideAverage(:, [2 3 4 6 8 9 10 12]);
% mideSobel = mideSobel(:, [2 3 4 6 8 9 10 12]);

% conf.descr = sprintf(strModel, 'mideAverage');
% evaluateData(mideAverage, conf)

% conf.descr = sprintf(strModel, 'mideSobel');
% evaluateData(mideSobel, conf)


% ---------- LBP ----------
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 4;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 8;
conf.extraSVMRBF.sigma = 4;

conf.extraLSSVMLinear.metodo = 'SMO';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 4;

conf.extraLSSVMRBF.metodo = 'SMO';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 4;
conf.extraLSSVMRBF.sigma = 8;

conf.extraMLP = 10;
conf.descr = sprintf(strModel, 'lbp');
evaluateData(lbp, conf)


% ---------- Hu Moments ----------
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 64;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 128;
conf.extraSVMRBF.sigma = 1;

conf.extraLSSVMLinear.metodo = 'SMO';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 4;

conf.extraLSSVMRBF.metodo = 'SMO';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 1024;
conf.extraLSSVMRBF.sigma = 1;

conf.extraMLP = 25;
conf.descr = sprintf(strModel, 'hu');
evaluateData(hu, conf)



% ---------- Haralick ----------
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 64;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 32;
conf.extraSVMRBF.sigma = 2;

conf.extraLSSVMLinear.metodo = 'SMO';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 2048;

conf.extraLSSVMRBF.metodo = 'SMO';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 1042;
conf.extraLSSVMRBF.sigma = 2;

conf.extraMLP = 25;
conf.descr = sprintf(strModel, 'haralick');
evaluateData(haralick, conf)


% ---------- Central Moments ----------
load('../../data/central_real.mat');
% ---------- Haralick ----------
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 8;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 4;
conf.extraSVMRBF.sigma = 1;

conf.extraLSSVMLinear.metodo = 'SMO';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 4;

conf.extraLSSVMRBF.metodo = 'SMO';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 16;
conf.extraLSSVMRBF.sigma = 1;

conf.extraMLP = 20;
conf.descr = sprintf(strModel, 'central');
evaluateData(centralGoPro, conf)

% ---------- Statistics Moments ----------
load('../../data/statistic_real.mat');
% ---------- Haralick ----------
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 2048;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 256;
conf.extraSVMRBF.sigma = 2;

conf.extraLSSVMLinear.metodo = 'SMO';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 512;

conf.extraLSSVMRBF.metodo = 'SMO';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 512;
conf.extraLSSVMRBF.sigma = 2;

conf.extraMLP = 10;
conf.descr = sprintf(strModel, 'statistic');
evaluateData(statisticGoPro, conf)




%% Simulador
strModel = 'gray_%s_gopro_sim';
load(sprintf(sprintf('../../data/%s', strModel), 'all'));
% mideAverage = mideAverage(:, [2 3 4 6 8 9 10 12]);
% mideSobel = mideSobel(:, [2 3 4 6 8 9 10 12]);


% conf.descr = sprintf(strModel, 'mideAverage');
% evaluateData(mideAverage, conf)

% conf.descr = sprintf(strModel, 'mideSobel');
% evaluateData(mideSobel, conf)


% ---------- LBP ----------
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = ;
% 
% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = ;
% conf.extraSVMRBF.sigma = ;
% 
% conf.extraLSSVMLinear.metodo = 'SMO';
% conf.extraLSSVMLinear.options.MaxIter = 9000000;
% conf.extraLSSVMLinear.fkernel = 'linear';
% conf.extraLSSVMLinear.paraC = ;
% 
% conf.extraLSSVMRBF.metodo = 'SMO';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = ;
% conf.extraLSSVMRBF.sigma = ;
conf = rmfield(conf, 'extraLSSVMLinear');
conf = rmfield(conf, 'extraLSSVMRBF');
conf = rmfield(conf, 'extraSVMLinear');
conf = rmfield(conf, 'extraSVMRBF');

conf.extraMLP = 10;
conf.descr = sprintf(strModel, 'lbp');
evaluateData(lbp, conf)


% ---------- Hu Moments ----------
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 32;

% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = ;
% conf.extraSVMRBF.sigma = ;

conf.extraLSSVMLinear.metodo = 'SMO';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 4;

% conf.extraLSSVMRBF.metodo = 'SMO';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = ;
% conf.extraLSSVMRBF.sigma = ;

conf.extraMLP = 20;
conf.descr = sprintf(strModel, 'hu');
evaluateData(hu, conf)



% ---------- Haralick ----------
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 64;

% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = ;
% conf.extraSVMRBF.sigma = ;

conf.extraLSSVMLinear.metodo = 'SMO';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 2048;

% conf.extraLSSVMRBF.metodo = 'SMO';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = ;
% conf.extraLSSVMRBF.sigma = ;

conf.extraMLP = 10;
conf.descr = sprintf(strModel, 'haralick');
evaluateData(haralick, conf)


% ---------- Central Moments ----------
load('../../data/central_sim.mat');
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 4;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 4;
conf.extraSVMRBF.sigma = 1;

conf.extraLSSVMLinear.metodo = 'SMO';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 4;

conf.extraLSSVMRBF.metodo = 'SMO';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 128;
conf.extraLSSVMRBF.sigma = 1;

conf.extraMLP = 50;
conf.descr = sprintf(strModel, 'central');
evaluateData(centralGoPro, conf)


% ---------- Statistics Moments ----------
load('../../data/statistic_sim.mat');
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 1024;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 512;
conf.extraSVMRBF.sigma = 1;

conf.extraLSSVMLinear.metodo = 'SMO';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 1024;

conf.extraLSSVMRBF.metodo = 'SMO';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 2048;
conf.extraLSSVMRBF.sigma = 1;

conf.extraMLP = 15;
conf.descr = sprintf(strModel, 'statistic');
evaluateData(statisticGoPro, conf)
