clear all; close all; clc;
addpath('../Classification/percetron/'); addpath('../Classification/MLM/');
addpath('../Classification/MLP/'); addpath('../Classification/multisvm/');
addpath('../Classification/bayes/'); addpath('../utils/');


% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}
%% General configurations
conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', ...
    'lssvmRBF', 'mlm', 'mlmNN'};
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
strModel = 'gray_%s_gopro_real';
load(sprintf(sprintf('../../data/%s', strModel), 'all'));

% mideAverage = mideAverage(:, [2 3 4 6 8 9 10 12]);
% mideSobel = mideSobel(:, [2 3 4 6 8 9 10 12]);
% conf.descr = sprintf(strModel, 'mideAverage');
% evaluate_ml_route(mideAverage, conf)
% conf.descr = sprintf(strModel, 'mideSobel');
% evaluate_ml_route(mideSobel, conf)


% % ---------- LBP ----------
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 4;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 4;
conf.extraSVMRBF.sigma = 8;

conf.extraLSSVMLinear.metodo = 'LS';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 4;

conf.extraLSSVMRBF.metodo = 'LS';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 8;
conf.extraLSSVMRBF.sigma = 4;

conf.extraMLP = 10;
conf.descr = sprintf(strModel, 'lbp');
evaluate_ml_route(lbp, conf)


% % ---------- Hu Moments ----------
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 64;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 128;
conf.extraSVMRBF.sigma = 1;

conf.extraLSSVMLinear.metodo = 'LS';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 4;

conf.extraLSSVMRBF.metodo = 'LS';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 1024;
conf.extraLSSVMRBF.sigma = 1;

conf.extraMLP = 25;
conf.descr = sprintf(strModel, 'hu');
evaluate_ml_route(hu, conf)



% % ---------- Haralick ----------
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 64;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 32;
conf.extraSVMRBF.sigma = 2;

conf.extraLSSVMLinear.metodo = 'LS';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 2048;

conf.extraLSSVMRBF.metodo = 'LS';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 1042;
conf.extraLSSVMRBF.sigma = 2;

conf.extraMLP = 25;
conf.descr = sprintf(strModel, 'haralick');
evaluate_ml_route(haralick, conf)


% ---------- Central Moments ----------
load('../../data/central_real.mat');
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 8;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 4;
conf.extraSVMRBF.sigma = 1;

conf.extraLSSVMLinear.metodo = 'LS';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 1024;

conf.extraLSSVMRBF.metodo = 'LS';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 2048;
conf.extraLSSVMRBF.sigma = 2;

conf.extraMLP = 20;
conf.descr = sprintf(strModel, 'central');
evaluate_ml_route(centralGoPro, conf)


% ---------- Statistics Moments ----------
load('../../data/statistic_real.mat');
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 2048;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 256;
conf.extraSVMRBF.sigma = 2;

conf.extraLSSVMLinear.metodo = 'LS';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 16;

conf.extraLSSVMRBF.metodo = 'LS';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 2048;
conf.extraLSSVMRBF.sigma = 1;

conf.extraMLP = 10;
conf.descr = sprintf(strModel, 'statistic');
evaluate_ml_route(statisticGoPro, conf)



% %% ------------------ SIMULATION ------------------
% strModel = 'gray_%s_gopro_sim';
% load(sprintf(sprintf('../../data/%s', strModel), 'all'));
% 
% % mideAverage = mideAverage(:, [2 3 4 6 8 9 10 12]);
% % mideSobel = mideSobel(:, [2 3 4 6 8 9 10 12]);
% % conf.descr = sprintf(strModel, 'mideAverage');
% % evaluate_ml_route(mideAverage, conf)
% % conf.descr = sprintf(strModel, 'mideSobel');
% % evaluate_ml_route(mideSobel, conf)
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
% evaluate_ml_route(lbp, conf)

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
% evaluate_ml_route(hu, conf)
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
% evaluate_ml_route(haralick, conf)
% 
% 
% 
% % % ---------- Central Moments ----------
% load('../../data/central_sim.mat');
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
% conf.extraMLP = 50;
% conf.descr = sprintf(strModel, 'central');
% evaluate_ml_route(centralSim, conf)
% 
% 
% % ---------- Statistics Moments ----------
% load('../../data/statistic_sim.mat');
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
% conf.descr = sprintf(strModel, 'statistic');
% evaluate_ml_route(statisticsSim, conf)
