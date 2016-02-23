clear all; clc;
addpath('SIFT/'); addpath('SURF/'); 

% testTime_sim_omni
% save('surf_time_sim_omni', 'timeTest', 'timeTrain')
% 
% runVLFeat_sim
% save('sift_time_sim_omni', 'timeTest', 'timeTrain')


% testTime_real_omni
% save('surf_time_real_omni', 'timeTest', 'timeTrain')

runVLFeat_omni
save('sift_time_real_omni', 'timeTest', 'timeTrain')