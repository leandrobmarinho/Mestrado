clear; close all; clc;
addpath('../Classification/percetron/'); addpath('../Classification/MLM/');
addpath('../Classification/MLP/'); addpath('../Classification/multisvm/');
addpath('../Classification/bayes/'); addpath('../utils/');


% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}
%% General configurations
conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp'};

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
strModel = 'scm_%s_omni_real';
load('../../data/scm_omni_real');
% load(sprintf('../../data/%s', strModel));

%% --- SCM Avrg
conf  = loadParamSCM( conf, 'omni', 'a');

conf.descr = sprintf(strModel, 'a');
evaluate_ml_route(dataSCM_a, conf)


%% --- SCM Gaussian
conf  = loadParamSCM( conf, 'omni', 'g');

conf.descr = sprintf(strModel, 'g');
evaluate_ml_route(dataSCM_g, conf)



%% --- SCM Laplacian
conf  = loadParamSCM( conf, 'omni', 'l');

conf.descr = sprintf(strModel, 'l');
evaluate_ml_route(dataSCM_l, conf)





%% --- SCM Sobel
conf  = loadParamSCM( conf, 'omni', 's');

conf.descr = sprintf(strModel, 's');
evaluate_ml_route(dataSCM_s, conf)