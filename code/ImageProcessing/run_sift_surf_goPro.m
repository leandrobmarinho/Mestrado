clear all; clc;
addpath('SIFT/'); addpath('SURF/'); 

testTimeSim
save('surf_time_sim', 'timeTest', 'timeTrain')

runVLFeat_sim
save('sift_time_sim', 'timeTest', 'timeTrain')

% testTimeReal
% save('surf_time_real', 'timeTest', 'timeTrain')
% 
% runVLFeat
% save('sift_time_real', 'timeTest', 'timeTrain')