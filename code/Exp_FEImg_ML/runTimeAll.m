clear all; close all; clc;
addpath('../Classification/percetron/'); addpath('../Classification/MLM/');
addpath('../Classification/MLP/'); addpath('../Classification/multisvm/');
addpath('../Classification/bayes/'); addpath('../utils/');


%% General configurations
% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}
conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', ...
    'lssvmRBF', 'mlm', 'mlmNN'};
conf.numRep = 5;

conf.mlMethods = {'mlp'};
%% ------------------ REAL ------------------
% strModel = 'gray_%s_gopro_real';
% load(sprintf(sprintf('../../data/%s', strModel), 'all'));

% mideAverage = mideAverage(:, [2 3 4 6 8 9 10 12]);
% mideSobel = mideSobel(:, [2 3 4 6 8 9 10 12]);
% conf.descr = sprintf(strModel, 'mideAverage');
% evaluate_ml(mideAverage, conf)
% conf.descr = sprintf(strModel, 'mideSobel');
% evaluate_ml(mideSobel, conf)


% % ---------- LBP ----------
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 4;
% 
% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = 4;
% conf.extraSVMRBF.sigma = 8;
% 
% conf.extraLSSVMLinear.metodo = 'LS';
% conf.extraLSSVMLinear.options.MaxIter = 9000000;
% conf.extraLSSVMLinear.fkernel = 'linear';
% conf.extraLSSVMLinear.paraC = 4;
% 
% conf.extraLSSVMRBF.metodo = 'LS';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = 8;
% conf.extraLSSVMRBF.sigma = 4;
% 
% conf.extraMLP = 10;
% conf.descr = sprintf(strModel, 'lbp');
% evaluate_ml(lbp, conf)


% % ---------- Hu Moments ----------
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 64;
% 
% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = 128;
% conf.extraSVMRBF.sigma = 1;
% 
% conf.extraLSSVMLinear.metodo = 'LS';
% conf.extraLSSVMLinear.options.MaxIter = 9000000;
% conf.extraLSSVMLinear.fkernel = 'linear';
% conf.extraLSSVMLinear.paraC = 4;
% 
% conf.extraLSSVMRBF.metodo = 'LS';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = 1024;
% conf.extraLSSVMRBF.sigma = 1;
% 
% conf.extraMLP = 25;
% conf.descr = sprintf(strModel, 'hu');
% evaluate_ml(hu, conf)



% % ---------- Haralick ----------
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 64;
% 
% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = 32;
% conf.extraSVMRBF.sigma = 2;
% 
% conf.extraLSSVMLinear.metodo = 'LS';
% conf.extraLSSVMLinear.options.MaxIter = 9000000;
% conf.extraLSSVMLinear.fkernel = 'linear';
% conf.extraLSSVMLinear.paraC = 2048;
% 
% conf.extraLSSVMRBF.metodo = 'LS';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = 1042;
% conf.extraLSSVMRBF.sigma = 2;
% 
% conf.extraMLP = 25;
% conf.descr = sprintf(strModel, 'haralick');
% evaluate_ml(haralick, conf)


% ---------- Central Moments ----------
% load('../../data/central_real.mat');
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 8;
% 
% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = 4;
% conf.extraSVMRBF.sigma = 1;
% 
% conf.extraLSSVMLinear.metodo = 'LS';
% conf.extraLSSVMLinear.options.MaxIter = 9000000;
% conf.extraLSSVMLinear.fkernel = 'linear';
% conf.extraLSSVMLinear.paraC = 1024;
% 
% conf.extraLSSVMRBF.metodo = 'LS';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = 2048;
% conf.extraLSSVMRBF.sigma = 2;
% 
% conf.extraMLP = 20;
% conf.descr = sprintf(strModel, 'central');
% evaluate_ml(centralGoPro, conf)


% ---------- Statistics Moments ----------
% load('../../data/statistic_real.mat');
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 2048;
% 
% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = 256;
% conf.extraSVMRBF.sigma = 2;
% 
% conf.extraLSSVMLinear.metodo = 'LS';
% conf.extraLSSVMLinear.options.MaxIter = 9000000;
% conf.extraLSSVMLinear.fkernel = 'linear';
% conf.extraLSSVMLinear.paraC = 16;
% 
% conf.extraLSSVMRBF.metodo = 'LS';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = 2048;
% conf.extraLSSVMRBF.sigma = 1;
% 
% conf.extraMLP = 10;
% conf.mlMethods = {'bayes'};
% conf.descr = sprintf(strModel, 'statistic');
% evaluate_ml(statisticGoPro, conf)



% %% ------------------ SIMULATION ------------------
strModel = 'gray_%s_gopro_sim';
load(sprintf(sprintf('../../data/%s', strModel), 'all'));
% 
% % mideAverage = mideAverage(:, [2 3 4 6 8 9 10 12]);
% % mideSobel = mideSobel(:, [2 3 4 6 8 9 10 12]);
% % conf.descr = sprintf(strModel, 'mideAverage');
% % evaluate_ml(mideAverage, conf)
% % conf.descr = sprintf(strModel, 'mideSobel');
% % evaluate_ml(mideSobel, conf)
% 
% 
% % ---------- LBP ----------
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 4;
% 
% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = 8;
% conf.extraSVMRBF.sigma = 4;
% 
% conf.extraLSSVMLinear.metodo = 'LS';
% conf.extraLSSVMLinear.options.MaxIter = 9000000;
% conf.extraLSSVMLinear.fkernel = 'linear';
% conf.extraLSSVMLinear.paraC = 8;
% 
% conf.extraLSSVMRBF.metodo = 'LS';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = 512;
% conf.extraLSSVMRBF.sigma = 4;
% 
% conf.extraMLP = 10;
% conf.descr = sprintf(strModel, 'lbp');
% evaluate_ml(lbp, conf)

% 
% % ---------- Hu Moments ----------
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 32;
% 
% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = 32;
% conf.extraSVMRBF.sigma = 1;
% 
% conf.extraLSSVMLinear.metodo = 'LS';
% conf.extraLSSVMLinear.options.MaxIter = 9000000;
% conf.extraLSSVMLinear.fkernel = 'linear';
% conf.extraLSSVMLinear.paraC = 4;
% 
% conf.extraLSSVMRBF.metodo = 'LS';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = 256;
% conf.extraLSSVMRBF.sigma = 1;
% 
% conf.extraMLP = 20;
% conf.descr = sprintf(strModel, 'hu');
% evaluate_ml(hu, conf)
% 
% 
% 
% % ---------- Haralick ----------
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 64;
% 
% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = 1024;
% conf.extraSVMRBF.sigma = 2;
% 
% conf.extraLSSVMLinear.metodo = 'LS';
% conf.extraLSSVMLinear.options.MaxIter = 9000000;
% conf.extraLSSVMLinear.fkernel = 'linear';
% conf.extraLSSVMLinear.paraC = 2048;
% 
% conf.extraLSSVMRBF.metodo = 'LS';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = 512;
% conf.extraLSSVMRBF.sigma = 2;
% 
% conf.extraMLP = 10;
% conf.descr = sprintf(strModel, 'haralick');
% evaluate_ml(haralick, conf)
% 
% 
% 
% % % ---------- Central Moments ----------
load('../../data/central_sim.mat');
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 4;
% 
% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = 4;
% conf.extraSVMRBF.sigma = 1;
% 
% conf.extraLSSVMLinear.metodo = 'LS';
% conf.extraLSSVMLinear.options.MaxIter = 9000000;
% conf.extraLSSVMLinear.fkernel = 'linear';
% conf.extraLSSVMLinear.paraC = 1024;
% 
% conf.extraLSSVMRBF.metodo = 'LS';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = 64;
% conf.extraLSSVMRBF.sigma = 1;
% 
conf.extraMLP = 50;
conf.descr = sprintf(strModel, 'central');
evaluate_ml(centralSim, conf)
% 
% 
% % ---------- Statistics Moments ----------
load('../../data/statistic_sim.mat');
% conf.extraSVMLinear.metodo = 'SMO';
% conf.extraSVMLinear.options.MaxIter = 9000000;
% conf.extraSVMLinear.fkernel = 'linear';
% conf.extraSVMLinear.paraC = 1024;
% 
% conf.extraSVMRBF.metodo = 'SMO';
% conf.extraSVMRBF.options.MaxIter = 9000000;
% conf.extraSVMRBF.fkernel = 'rbf';
% conf.extraSVMRBF.paraC = 512;
% conf.extraSVMRBF.sigma = 1;
% 
% conf.extraLSSVMLinear.metodo = 'LS';
% conf.extraLSSVMLinear.options.MaxIter = 9000000;
% conf.extraLSSVMLinear.fkernel = 'linear';
% conf.extraLSSVMLinear.paraC = 1024;
% 
% conf.extraLSSVMRBF.metodo = 'LS';
% conf.extraLSSVMRBF.options.MaxIter = 9000000;
% conf.extraLSSVMRBF.fkernel = 'rbf';
% conf.extraLSSVMRBF.paraC = 2048;
% conf.extraLSSVMRBF.sigma = 1;
% 
% conf.extraMLP = 15;
% 
conf.descr = sprintf(strModel, 'statistic');
evaluate_ml(statisticsSim, conf)
