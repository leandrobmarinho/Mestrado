clear all; close all; clc;
addpath('../percetron/'); addpath('../MLM/'); addpath('../MLP/');
addpath('../multisvm/'); addpath('../bayes/'); addpath('../');

%% General configurations
conf.mlMethods = {'bayes', 'svm', 'mlp', 'lssvm', 'mlm', 'mlmNN'};
% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}



%% ======= Gray - Real =======
% strModel = 'gray_%s_gopro_real';
% load(sprintf(sprintf('../dados/%s', strModel), 'all'));
% mideAverage = mideAverage(:, [2 3 6 8 9 10 12]);
% 
% conf.descr = sprintf(strModel, 'mideAverage');
% evaluateData(mideAverage, conf)
% 
% conf.descr = sprintf(strModel, 'mideSobel');
% evaluateData(mideSobel, conf)
% 
% conf.descr = sprintf(strModel, 'lbp');
% evaluateData(lbp, conf)
% 
% conf.descr = sprintf(strModel, 'hu');
% evaluateData(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evaluateData(haralick, conf)


%% ======= Gray - Sim =======
strModel = 'gray_%s_gopro_sim';
load(sprintf(sprintf('../dados/%s', strModel), 'all'));
mideAverage = mideAverage(:, [2 3 6 8 9 10 12]);
mideSobel = mideSobel(:, [2 3 6 8 9 10 12]);


conf.descr = sprintf(strModel, 'mideAverage');
evaluateData(mideAverage, conf)

conf.descr = sprintf(strModel, 'mideSobel');
evaluateData(mideSobel, conf)

conf.descr = sprintf(strModel, 'lbp');
evaluateData(lbp, conf)

conf.descr = sprintf(strModel, 'hu');
evaluateData(hu, conf)

conf.descr = sprintf(strModel, 'haralick');
evaluateData(haralick, conf)
