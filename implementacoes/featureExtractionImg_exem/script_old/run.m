clear all; close all; clc;
addpath('../percetron/'); addpath('../MLM/'); addpath('../SVM/');
addpath('../multisvm/');

%% Load data and Pre-processing
load('../dados/feature_extraction_imgs.mat');
data.x = lbp(:,1:end-1);
y = lbp(:,end);

labels = unique(y);
code = zeros(length(labels), length(labels));
for j = 1: length(labels),
    code(j, j) = 1;
end

for j = length(labels):-1:1,
    ind = (y == labels(j));
    tam = length(find(ind==1));
    data.y(ind, :) = repmat(code(j, :), tam, 1);
end
clear y;

% clear all
% data = carregaDados('iris.data', 0);


%% General Configurations
ptrn = 0.8;
numRep = 2;
numFolds = 2;

%% Perceptron
conf.epocas = 100;
i = 1;
for alfa = [0.1 0.01]
    conf.alfa = alfa;
    
    params{i} = conf;
    i = i + 1;
end

resPerceptron = perceptronSim(data, ptrn, numRep, params, numFolds);



%% MLM
% config.method = 'knn'; % lsqnonlin knn ''
% for dist = {'mahalanobis', 'cityblock', ''}
%     
%     for k = [0.1 0.5 1]
%         config.k = k;
%         config.NN = 9;
%         config.distance = dist{1}; % mahalanobis cityblock ''
%         resMLM = simMLM(data, ptrn, numRep, config);
%         
%         save(sprintf('mlm_%s_%d_D-%s_%.0f', config.method, config.NN,...
%             config.distance, config.k*100), 'resMLM', 'config')
%         
%         fprintf(sprintf('mlm_%s_%d_D-%s_%.0f\n', config.method, config.NN,...
%             config.distance, config.k*100))
%     end    
% end

%% SVM
% data.y = vec2ind(data.y')';
% conf.metodo = 'LS';
% conf.fkernel = 'rbf';
% conf.options.MaxIter = 9000000;
% 
% paraC = 2.^(-5:2:9);
% 
% i = 1;
% if (strcmp('rbf', conf.fkernel) == 1)
%     for sigma = 2.^(-10:5)
%         
%         for c = paraC
%             conf.paraC = c;
%             conf.sigma = sigma;
%             
%             params{i} = conf;
%             i = i + 1;
%         end
%     end
% else
%     
%     for c = paraC
%         conf.paraC = c;
% 
%         params{i} = conf;
%         i = i + 1;
%     end
% end
% resultSVM = simMultiSVM( data, numRep, ptrn, params, numFolds )
 
 
