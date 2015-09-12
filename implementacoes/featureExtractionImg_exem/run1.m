clear all; close all; clc;
addpath('../percetron/'); addpath('../MLM/'); addpath('../MLP/');
addpath('../multisvm/'); addpath('../bayes/'); addpath('../');

%% General configurations
conf.mlMethods = {'bayes', 'svm', 'mlp'};
conf.mlMethods = {'mlp'};
% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}



%% ======= Gray - All_MideAverage - Real =======
% strModel = 'gray_%s_gopro_real';
% load(sprintf(sprintf('../dados/%s', strModel), 'all-mideAverage'));
% 
% conf.descr = sprintf(strModel, 'mideAverage');
% evaluateData(mide, conf)
% 
% conf.descr = sprintf(strModel, 'lbp');
% evaluateData(lbp, conf)
% 
% conf.descr = sprintf(strModel, 'hu');
% evaluateData(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evaluateData(haralick, conf)



%% ======= Gray - All_MideSobel - Real =======
strModel = 'gray_%s_gopro_real';
load(sprintf(sprintf('../dados/%s', strModel), 'all'));

conf.descr = sprintf(strModel, 'mideSobel');
evaluateData(mide, conf)

% conf.descr = sprintf(strModel, 'lbp');
% evaluateData(lbp, conf)
% 
% conf.descr = sprintf(strModel, 'hu');
% evaluateData(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evaluateData(haralick, conf)



%% ======= Gray - All_MideAverage - Sim =======
% strModel = 'gray_%s_gopro_sim';
% load(sprintf(sprintf('../dados/%s', strModel), 'all-mideAverage'));
% 
% conf.descr = sprintf(strModel, 'mideAverage');
% evaluateData(mide, conf)
% 
% conf.descr = sprintf(strModel, 'lbp');
% evaluateData(lbp, conf)
% 
% conf.descr = sprintf(strModel, 'hu');
% evaluateData(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evaluateData(haralick, conf)



%% ======= Gray - All_MideSobel - Sim =======
% strModel = 'gray_%s_gopro_sim';
% load(sprintf(sprintf('../dados/%s', strModel), 'all-mideSobel'));
% 
% conf.descr = sprintf(strModel, 'mideSobel');
% evaluateData(mide, conf)
% 
% conf.descr = sprintf(strModel, 'lbp');
% evaluateData(lbp, conf)
% 
% conf.descr = sprintf(strModel, 'hu');
% evaluateData(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evaluateData(haralick, conf)
