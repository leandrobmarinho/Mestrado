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
% evalueteData(mide, conf)
% 
% conf.descr = sprintf(strModel, 'lbp');
% evalueteData(lbp, conf)
% 
% conf.descr = sprintf(strModel, 'hu');
% evalueteData(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evalueteData(haralick, conf)



%% ======= Gray - All_MideSobel - Real =======
strModel = 'gray_%s_gopro_real';
load(sprintf(sprintf('../dados/%s', strModel), 'all-mideSobel'));

conf.descr = sprintf(strModel, 'mideSobel');
evalueteData(mide, conf)

% conf.descr = sprintf(strModel, 'lbp');
% evalueteData(lbp, conf)
% 
% conf.descr = sprintf(strModel, 'hu');
% evalueteData(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evalueteData(haralick, conf)



%% ======= Gray - All_MideAverage - Sim =======
% strModel = 'gray_%s_gopro_sim';
% load(sprintf(sprintf('../dados/%s', strModel), 'all-mideAverage'));
% 
% conf.descr = sprintf(strModel, 'mideAverage');
% evalueteData(mide, conf)
% 
% conf.descr = sprintf(strModel, 'lbp');
% evalueteData(lbp, conf)
% 
% conf.descr = sprintf(strModel, 'hu');
% evalueteData(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evalueteData(haralick, conf)



%% ======= Gray - All_MideSobel - Sim =======
% strModel = 'gray_%s_gopro_sim';
% load(sprintf(sprintf('../dados/%s', strModel), 'all-mideSobel'));
% 
% conf.descr = sprintf(strModel, 'mideSobel');
% evalueteData(mide, conf)
% 
% conf.descr = sprintf(strModel, 'lbp');
% evalueteData(lbp, conf)
% 
% conf.descr = sprintf(strModel, 'hu');
% evalueteData(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evalueteData(haralick, conf)
