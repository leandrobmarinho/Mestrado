function [ labels, time, outputs ] = testMultSVM( models, TestSet)
%TESTMULTSVM Summary of this function goes here
%   Detailed explanation goes here

tic
labels = []; outputs = [];
for k=1:length(models)
    [~, o] = svmclassify2(models(k), TestSet);
%     labels = [labels l];
    outputs = [outputs o];
end
time = toc;
[~, inds] = sort(outputs', 'ascend');
labels = inds(1,:);


end

