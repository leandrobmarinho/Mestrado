clear all; close all; clc;
addpath('../percetron/'); addpath('../MLM/'); addpath('../MLP/');
addpath('../multisvm/'); addpath('../bayes/'); addpath('../');

%% General configurations
conf.mlMethods = {'lssvm'};
% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}



%% ======= Gray - Real =======
% strModel = 'gray_%s_gopro_real';
% load(sprintf(sprintf('../dados/%s', strModel), 'all'));
% 
% conf.descr = sprintf(strModel, 'mideAverage');
% evalueteData(mideAverage, conf)
% 
% conf.descr = sprintf(strModel, 'mideSobel');
% evalueteData(mideSobel, conf)
% 
% conf.descr = sprintf(strModel, 'lbp');
% evalueteData(lbp, conf)
% 
% conf.descr = sprintf(strModel, 'hu');
% evalueteData(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evalueteData(haralick, conf)




%% ======= Gray - Sim =======
strModel = 'gray_%s_gopro_sim';
load(sprintf(sprintf('../dados/%s', strModel), 'all'));

% conf.descr = sprintf(strModel, 'mideAverage');
% evalueteData(mideAverage, conf)
% 
% conf.descr = sprintf(strModel, 'mideSobel');
% evalueteData(mideSobel, conf)
% 
% conf.descr = sprintf(strModel, 'lbp');
% evalueteData(lbp, conf)

conf.descr = sprintf(strModel, 'hu');
evalueteData(hu, conf)

conf.descr = sprintf(strModel, 'haralick');
evalueteData(haralick, conf)
