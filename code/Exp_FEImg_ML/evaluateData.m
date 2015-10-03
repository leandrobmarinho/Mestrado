function [ ] = evaluateData( dataset, params )
%EVALUETEDATA Evalute the dataset using the Machine Learning methods
%   data - matrix with data [X Y], Y is a line vector with numbers of the 
%           classes
%   conf - 
%           ptrain - percentual of train
%           numRep - number of repetitions
%           descr - string with model of names to save
%           mlMethods = methods to evaluate {'bayes', 'svm', 'mlp', 'lssvm', 'mlm', 'mlmNN'}


if (isfield(params, 'normaliza') == 0)
    normaliza = true;
else
    normaliza = params.normaliza;
end

%% Validation
if (isfield(params, 'ptrain') == 0)    
    ptrn = .8;
else
    ptrn = params.ptrain;
end

if (isfield(params, 'numRep') == 0)    
    numRep = 10;
else
    numRep = params.numRep;
end

if (isfield(params, 'distMLM'))
    distMLM = params.distMLM;
else
    distMLM = {'cityblock', '', 'mahalanobis' };
end

if (isfield(params, 'distMLM_NN'))
    distMLM_NN = params.distMLM_NN;
else
    distMLM_NN = {'cityblock', '', 'mahalanobis' };
end

descr = params.descr;


% data.x = dataset(:,1:end-1);
% data.y = dataset(:, end);

[data.x, ia, ~] = unique(dataset(:,1:end-1), 'rows');
data.y = dataset(ia, end);

if normaliza
    data.x = normalizeData(data.x, 1);
end

%% Evaluate
%% =============== Bayes ===============
if(find(ismember(params.mlMethods,'bayes')))

    config.custo = 1 - eye(length(unique(data.y)));
    config.algoritmo = '';
    
    result = simBayes(data, ptrn, 50, config);

    strModel = sprintf('%s_%s', descr, 'bayes');   
    save(strModel, 'result', 'config')
    fprintf('%s\n', strModel)
end


% C from LSSVM and SVM
% paraC = 2.^(-3:2:15);
paraC = 2.^(2:11); %2.^(2:11);
sigmas = 2.^(0:3); %2.^(-3:3);
%% =============== SVM (Linear) ===============

clear config
if(find(ismember(params.mlMethods,'svmLinear')))
    try

    config.metodo = 'SMO';
    config.fkernel = 'linear';
    config.options.MaxIter = 9000000;
        
    i = 1;
    for c = paraC
        config.paraC = c;
        
        paramsSVM{i} = config;
        i = i + 1;
    end

    if isfield(params,'extraSVMLinear')
        optParam = params.extraSVMLinear;
    else
        optParam = searchParamSVM(data, paramsSVM, 3, ptrn );
    end
    result = simMultiSVM( data, ptrn, numRep, optParam );
    
    strModel = sprintf('%s_%s-%s', descr, 'svm', config.fkernel);    
    save(strModel, 'result', 'config', 'optParam')
    fprintf('%s\n', strModel)

    catch
         fprintf('========= Erro no SVM =========\n');
    end

    
end
   
%% =============== SVM (RBF) ===============
clear config
clear paramsSVM
if(find(ismember(params.mlMethods,'svmRBF')))
    try
    
    config.metodo = 'SMO';    
    config.options.MaxIter = 9000000;
    config.fkernel = 'rbf';
    
    i = 1;
    for sigma = sigmas %2.^(-10:5)
        
        for c = paraC
            config.paraC = c;
            config.sigma = sigma;
            
            paramsSVM{i} = config;
            i = i + 1;
        end
    end
    
    if isfield(params,'extraRBF')
        optParam = params.extraRBF;
    else
        optParam = searchParamSVM(data, paramsSVM, 3, ptrn );
    end
    result = simMultiSVM( data, ptrn, numRep, optParam );
            
    strModel = sprintf('%s_%s-%s', descr, 'svm', config.fkernel);    
    save(strModel, 'result', 'config', 'optParam')
    fprintf('%s\n', strModel)
    
    catch
        fprintf('========= Erro no SVM =========\n');
    end
end



%% =============== MLP ===============
clear config
clear paramsSVM
if(find(ismember(params.mlMethods,'mlp')))
    if ( size(data.y, 2) == 1)
        data.y = full(ind2vec(data.y'))';
    end

    %paramsMLP = [50 100:10:200 250 300];
    %paramsMLP = 2.^(1:9);
%     paramsMLP = [10:10:300];
%     paramsMLP = [10:10:150 200:20:340];
%     paramsMLP = [10:10:150 200:20:240];

    paramsMLP = 5:5:50;
    
    optParam = searchTopologyMLP(data, paramsMLP, 3, ptrn );    
    result = simMLP(data, ptrn, numRep, optParam );
    
    strModel = sprintf('%s_%s', descr, 'mlp');    
    save(strModel, 'result', 'optParam')
    fprintf('%s\n', strModel)

end



%% =============== LSSVM (Linear) ===============
clear config
clear paramsSVM
if(find(ismember(params.mlMethods,'lssvmLinear')))
    if ( size(data.y,2) > 1)
       data.y = vec2ind(data.y')';
    end
    
    config.metodo = 'LS';
    config.options.MaxIter = 9000000;
    config.fkernel = 'linear';
    
        
    i = 1;
    for c = paraC
        config.paraC = c;
        
        paramsSVM{i} = config;
        i = i + 1;
    end
    
    optParam = searchParamSVM(data, paramsSVM, 3, ptrn );
    result = simMultiSVM( data, ptrn, numRep, optParam );
    
    strModel = sprintf('%s_%s-%s', descr, 'lssvm', config.fkernel);
    save(strModel, 'result', 'config', 'optParam')
    fprintf('%s\n', strModel)
    
    
end
    
%% =============== LSSVM (RBF) ===============
clear config
clear paramsSVM
if(find(ismember(params.mlMethods,'lssvmRBF')))
    if ( size(data.y,2) > 1)
       data.y = vec2ind(data.y')';
    end
    
    config.metodo = 'LS';
    config.options.MaxIter = 9000000;
    config.fkernel = 'rbf';
    
    i = 1;
    for sigma = sigmas
        
        for c = paraC
            config.paraC = c;
            config.sigma = sigma;
            
            paramsSVM{i} = config;
            i = i + 1;
        end
    end
    
    optParam = searchParamSVM(data, paramsSVM, 3, ptrn );
    result = simMultiSVM( data, ptrn, numRep, optParam );
    
    strModel = sprintf('%s_%s-%s', descr, 'lssvm', config.fkernel);
    save(strModel, 'result', 'config', 'optParam')
    fprintf('%s\n', strModel)
end




%% =============== Perceptron ===============
% TODO



%% =============== MLM ===============
clear config
if(find(ismember(params.mlMethods,'mlm')))

    if ( size(data.y, 2) == 1)
        data.y = full(ind2vec(data.y'))';
    end
    
    config.method = ''; % lsqnonlin knn ''
    config.k = 1;
    
    for dist = distMLM
        
        config.distance = dist{1}; % mahalanobis cityblock ''
        
        result = simMLM(data, ptrn, numRep, config);
        
        strModel = sprintf('%s_%s-D-%s-%.0f', descr, 'mlm', config.distance, config.k*100);
        save(strModel, 'result', 'config')
        fprintf('%s\n', strModel)        
        
    end
end



%% =============== MLM-NN ===============
clear config
if(find(ismember(params.mlMethods,'mlmNN')))

    if ( size(data.y, 2) == 1)
        data.y = full(ind2vec(data.y'))';
    end
    
    config.method = 'knn'; % lsqnonlin knn ''
    config.k = 1;
    config.NN = 1;
    
    for dist = distMLM_NN
        
        config.distance = dist{1};
        
        result = simMLM(data, ptrn, numRep, config);
        
        strModel = sprintf('%s_%s-%d-D-%s-%.0f', descr, 'mlmNN', config.NN, ...
        config.distance, config.k*100);
        save(strModel, 'result', 'config')
        fprintf('%s\n', strModel)        
        
    end
end

end

