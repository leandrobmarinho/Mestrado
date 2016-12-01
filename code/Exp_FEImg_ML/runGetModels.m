clear; close all; clc;
addpath('../Classification/percetron/'); addpath('../Classification/MLM/');
addpath('../Classification/MLP/'); addpath('../Classification/multisvm/');
addpath('../Classification/bayes/'); addpath('../utils/');


% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}
%% General configurations
conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', 'lssvmRBF'};
conf.mlMethods = {'svmLinear'};


%% ------------------ REAL ------------------
strModel = 'scm_%s_gopro_real';
load('../../data/scm_gopro_real');
% load(sprintf('../../data/%s', strModel));

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


%% --- SCM Avrg
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 1024;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 8192;
conf.extraSVMRBF.sigma = 4;

conf.extraLSSVMLinear.metodo = 'LS';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 1;

conf.extraLSSVMRBF.metodo = 'LS';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 64;
conf.extraLSSVMRBF.sigma = 2;

conf.extraMLP = 40;
conf.descr = sprintf(strModel, 'a');
getModels (dataSCM_a, conf);


%% --- SCM Gaussian
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 8192;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 4096;
conf.extraSVMRBF.sigma = 4;

conf.extraLSSVMLinear.metodo = 'LS';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 0.25;

conf.extraLSSVMRBF.metodo = 'LS';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 256;
conf.extraLSSVMRBF.sigma = 2;

conf.extraMLP = 80;
conf.descr = sprintf(strModel, 'g');
getModels (dataSCM_g, conf);



%% --- SCM Laplacian
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 256;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 128;
conf.extraSVMRBF.sigma = 2;

conf.extraLSSVMLinear.metodo = 'LS';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 4;

conf.extraLSSVMRBF.metodo = 'LS';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 64;
conf.extraLSSVMRBF.sigma = 2;

conf.extraMLP = 40;
conf.descr = sprintf(strModel, 'l');
getModels (dataSCM_l, conf);





%% --- SCM Sobel
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = 64;

conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = 4;
conf.extraSVMRBF.sigma = 0.5;

conf.extraLSSVMLinear.metodo = 'LS';
conf.extraLSSVMLinear.options.MaxIter = 9000000;
conf.extraLSSVMLinear.fkernel = 'linear';
conf.extraLSSVMLinear.paraC = 8;

conf.extraLSSVMRBF.metodo = 'LS';
conf.extraLSSVMRBF.options.MaxIter = 9000000;
conf.extraLSSVMRBF.fkernel = 'rbf';
conf.extraLSSVMRBF.paraC = 4096;
conf.extraLSSVMRBF.sigma = 4;

conf.extraMLP = 60;
conf.descr = sprintf(strModel, 's');
getModels (dataSCM_s, conf);
