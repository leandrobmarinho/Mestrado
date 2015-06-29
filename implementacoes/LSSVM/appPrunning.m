% set methodology up
close all; clear all; clc;

realizations = 3;
train_percs = 80;

% set params up
params.gamma = 0.04;

% data loading
ds = DataSet('data.txt');
ds.normalize();

hit_rate = zeros(realizations,1);
sv_rate = zeros(realizations,1);
for i = 1 : realizations

    [train_features train_labels test_features test_labels] = ds.shuffle(train_percs);

    my = MyLSSVM(train_features, train_labels, params);
    my.train();

    %make decision function
    output_labels = my.classify(test_features);
    hit_rate(i,1) = length((output_labels - test_labels) == 0)/size(test_features,1);
    sv_rate(i,1) = length(my.alphas);
end

hit_mean_rate = sum(hit_rate)/length(hit_rate);
hit_mean_rate

hit_sv = (sum(sv_rate)/length(sv_rate));
hit_sv
hit_sv_rate =  (sum(sv_rate)/length(sv_rate))/size(train_features,1);
hit_sv_rate
