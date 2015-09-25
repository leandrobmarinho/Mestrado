clear all; close all; clc

[x,t] = iris_dataset;
net = patternnet(10)
net = train(net,x,t);
% view(net)
y = net(x);
perf = perform(net,t,y);
classes = vec2ind(y);

confusionmat(vec2ind(t), classes)


% %# load sample data
% load simpleclass_dataset
% input = simpleclassInputs;          %# 2x1000, 2-dimensional points
% output = simpleclassTargets;        %# 4x1000, 4 classes
% 
% %# split data into training/testing sets
% trainInd = 1:500;
% testInd = 501:1000;
% 
% %# create ANN and initialize network weights
% net = newpr(input, output, 3);
% net = init(net);
% net.trainParam.epochs = 25;        %# max number of iterations
% 
% %# learn net weights from training data
% net = train(net, input(:,trainInd), output(:,trainInd));
% 
% %# predict output of net on testing data
% pred = sim(net, input(:,testInd));
% 
% %# classification confusion matrix
% [err,cm] = confusion(output(:,testInd), pred);