clear; close all; clc;
addpath('../Classification/percetron/'); addpath('../Classification/MLM/');
addpath('../Classification/MLP/'); addpath('../Classification/multisvm/');
addpath('../Classification/bayes/'); addpath('../utils/');


% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}
%% General configurations
conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', ...
    'lssvmRBF', 'mlm', 'mlmNN'};
conf.mlMethods = {'mlp'};

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


%% ------------------ GoPro ------------------
strModel = 'gray_%s_gopro_real';
load(sprintf(sprintf('../../data/%s', strModel), 'all'));

% ---------- Statistics Moments ----------
conf.descr = sprintf(strModel, 'statistic');
conf = loadParam('statistic', 'gopro', conf);
getModels(statistic, conf);

% --- LBP ---
conf.descr = sprintf(strModel, 'lbp');
conf = loadParam('lbp', 'gopro', conf);
getModels(lbp, conf);

% ---------- Central Moments ----------
conf.descr = sprintf(strModel, 'central');
conf = loadParam('central', 'gopro', conf);
getModels(central, conf);


% ---------- Hu Moments ----------
conf.descr = sprintf(strModel, 'hu');
conf = loadParam('hu', 'gopro', conf);
getModels(hu, conf);


% ---------- Haralick ----------
haralick = haralick(:,[8 2 3 13 11 14 16 15 9 17 18 19 20 23]);
conf.descr = sprintf(strModel, 'haralick');
conf = loadParam('haralick', 'gopro', conf);
getModels(haralick, conf);


conf.mlMethods = {'bayes', 'svmLinear', 'svmRBF', 'mlp', 'lssvmLinear', ...
    'lssvmRBF', 'mlm', 'mlmNN'};
%% ------------------ Omni ------------------
strModel = 'gray_%s_omni_real';
load(sprintf(sprintf('../../data/%s', strModel), 'all'));

% --- LBP ---
conf.descr = sprintf(strModel, 'lbp');
conf = loadParam('lbp', 'omni', conf);
getModels(lbp, conf);

% ---------- Central Moments ----------
conf.descr = sprintf(strModel, 'central');
conf = loadParam('central', 'omni', conf);
getModels(central, conf);



% % ---------- Statistics Moments ----------
conf.descr = sprintf(strModel, 'statistic');
conf = loadParam('statistic', 'omni', conf);
getModels(statistic, conf);


% % ---------- Hu Moments ----------
conf.descr = sprintf(strModel, 'hu');
conf = loadParam('hu', 'omni', conf);
getModels(hu, conf);


% ---------- Haralick ----------
haralick = haralick(:,[8 2 3 13 11 14 16 15 9 17 18 19 20 23]);
conf.descr = sprintf(strModel, 'haralick');
conf = loadParam('haralick', 'omni', conf);
getModels(haralick, conf);