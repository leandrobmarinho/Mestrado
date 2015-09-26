clear all; close all; clc; p = path;
addpath('../percetron/'); addpath('../MLM/'); addpath('../MLP/');
addpath('../multisvm/'); addpath('../bayes/'); addpath('../');

%% General configurations
conf.mlMethods = {'bayes', 'svm', 'mlp', 'lssvm', 'mlm', 'mlmNN'};
% conf.normaliza = false;
% {gray,h}_{extrMethod_}_{gopro,omni}_{real,sim}_{mlMethod}



%% ======= Gray - Real =======
strModel = 'gray_%s_gopro_real';
load(sprintf(sprintf('../dados/%s', strModel), 'all'));

haralick = haralick(:,[- 23]);
hu = hu(:, [- 8]);
lbp = lbp(:, [- 60]);

% mideGrandMorf = mideGrandMorf(:, [- 12]);
mideSobel = mideSobel(:, [- 12]);
mideAverage = mideAverage(:, [- 12]);

% conf.descr = sprintf(strModel, 'mideGrandMorfSel_sel');
% evaluateData3(mideSobel, conf)

conf.descr = sprintf(strModel, 'mideAverage_sel');
evaluateData3(mideAverage, conf)

conf.descr = sprintf(strModel, 'mideSobel_sel');
evaluateData3(mideSobel, conf)

conf.descr = sprintf(strModel, 'lbp_sel');
evaluateData3(lbp, conf)

conf.descr = sprintf(strModel, 'hu_sel');
evaluateData3(hu, conf)

conf.descr = sprintf(strModel, 'haralick_sel');
evaluateData(haralick, conf)



%% ======= Gray - Sim =======
% strModel = 'gray_%s_gopro_sim';
% load(sprintf(sprintf('../dados/%s', strModel), 'all'));
% % mideAverage = mideAverage(:, [2 3 6 8 9 10 12]);
% 
% % mideSobel = mideSobel(:, [2 3 6 8 9 10 12]);
% % mideAverage = mideAverage(:, [2 3 6 12]);
% 
% haralick = haralick(:,[1:4 23]);
% hu = hu(:, [1:6 8]);
% lbp = lbp(:, [1:18 60]);
% 
% mideGrandMorf = mideGrandMorf(:, [ 2 3 6 8 12]);
% mideSobel = mideSobel(:, [ 2 3 6 8 12]);
% mideAverage = mideAverage(:, [2 3 6 12]);
% 
% % conf.descr = sprintf(strModel, 'mideAverage');
% % evaluateData2(mideAverage, conf)
% % 
% % conf.descr = sprintf(strModel, 'mideSobel');
% % evaluateData2(mideSobel, conf)
% % 
% % conf.descr = sprintf(strModel, 'mideGrandMorf');
% % evaluateData2(mideSobel, conf)
% 
% conf.descr = sprintf(strModel, 'lbp');
% evaluateData2(lbp, conf)
% 
% conf.descr = sprintf(strModel, 'hu');
% evaluateData2(hu, conf)
% 
% conf.descr = sprintf(strModel, 'haralick');
% evaluateData2(haralick, conf)