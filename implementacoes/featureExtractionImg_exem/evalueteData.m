function [ ] = evalueteData( dataset, params )
%EVALUETEDATA Evalute the dataset using the Machine Learning methods
%   data - matrix with data [X Y], Y is a line vector with numbers of the 
%           classes
%   conf - 
%           ptrain - percentual of train
%           numRep - number of repetitions
%           descr - string with model of names to save
%           mlMethods = methods to evaluate {'bayes', 'svm', 'mlp', 'lssvm', 'mlm', 'mlmNN'}

data.x = dataset(:,1:end-1);
data.y = dataset(:,end);


%% Verification
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
descr = params.descr;


%% Evaluate
%% =============== Bayes ===============
if(find(ismember(params.mlMethods,'bayes')))

    config.custo = 1 - eye(length(unique(data.y)));
    config.algoritmo = '';
    
    result = simBayes(data, ptrn, numRep, config);
    
    strModel = sprintf('%s_%s', descr, 'bayes');   
    save(strModel, 'result', 'config')
    fprintf('%s\n', strModel)
end


%% =============== SVM ===============
clear config
if(find(ismember(params.mlMethods,'svm')))

    % =================== SVM - Linear =================== 
    config.metodo = 'SMO';
    config.fkernel = 'linear';
    config.options.MaxIter = 9000000;
    
    paraC = 2.^(-5:2:9);
    
    i = 1;
    for c = paraC
        config.paraC = c;
        
        paramsSVM{i} = config;
        i = i + 1;
    end

    optParam = searchparamsSVMVM(data, paramsSVM, numRep, ptrn );
    result = simMultiSVM( data, ptrn, numRep, optParam );
    
    strModel = sprintf('%s_%s-%s', descr, 'svm', config.fkernel);    
    save(strModel, 'result', 'config', 'optParam')
    fprintf('%s\n', strModel)
    
    
    
    % =================== SVM - RBF =================== 
    clear paramsSVM
    config.fkernel = 'rbf';
    i = 1;
    for sigma = 2.^(-10:5)
        
        for c = paraC
            config.paraC = c;
            config.sigma = sigma;
            
            paramsSVM{i} = config;
            i = i + 1;
        end
    end
    
    optParam = searchparamsSVMVM(data, paramsSVM, numRep, ptrn );
    result = simMultiSVM( data, ptrn, numRep, optParam );
            
    strModel = sprintf('%s_%s-%s', descr, 'svm', config.fkernel);    
    save(strModel, 'result', 'config', 'optParam')
    fprintf('%s\n', strModel)
    
end



%% =============== MLP ===============
clear config
clear paramsSVM
if(find(ismember(params.mlMethods,'mlp')))
    
    paramsSVM = [50 100:10:200 250 300];
    
    optParam = searchTopologyMLP(data, paramsSVM, numRep, ptrn );
    result = simMLP(data, ptrn, numRep, optParam );
    
    strModel = sprintf('%s_%s', descr, 'mlp');    
    save(strModel, 'result', 'optParam')
    fprintf('%s\n', strModel)

end



%% =============== LSSVM ===============
clear config
clear paramsSVM
if(find(ismember(params.mlMethods,'lssvm')))
    
    % =================== LSSVM - Linear ===================
    config.metodo = 'LS';
    config.fkernel = 'linear';
    config.options.MaxIter = 9000000;
    
    paraC = 2.^(-5:2:9);
    
    i = 1;
    for c = paraC
        config.paraC = c;
        
        paramsSVM{i} = config;
        i = i + 1;
    end
    
    optParam = searchparamsSVMVM(data, paramsSVM, numRep, ptrn );
    result = simMultiSVM( data, ptrn, numRep, optParam );
    
    strModel = sprintf('%s_%s-%s', descr, 'lssvm', config.fkernel);
    save(strModel, 'result', 'config', 'optParam')
    fprintf('%s\n', strModel)
    
    
    
    
    % =============== LSSVM - RBF ===============
    clear paramsSVM
    config.fkernel = 'rbf';
    i = 1;
    for sigma = 2.^(-10:5)
        
        for c = paraC
            config.paraC = c;
            config.sigma = sigma;
            
            paramsSVM{i} = config;
            i = i + 1;
        end
    end
    
    optParam = searchparamsSVMVM(data, paramsSVM, numRep, ptrn );
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

    data.y = full(ind2vec(data.y'))';
    
    config.method = ''; % lsqnonlin knn ''
    config.k = 1;
    
    for dist = {'cityblock', '', 'mahalanobis', }
        
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

    data.y = full(ind2vec(data.y'))';
    
    config.method = 'knn'; % lsqnonlin knn ''
    config.k = 1;
    config.NN = 9;
    
    for dist = {'cityblock', '', 'mahalanobis', }
        
        config.distance = dist{1}; % mahalanobis cityblock ''
        
        result = simMLM(data, ptrn, numRep, config);
        
        strModel = sprintf('%s_%s-%d-D-%s-%.0f', descr, 'mlmNN', config.NN, ...
        config.distance, config.k*100);
        save(strModel, 'result', 'config')
        fprintf('%s\n', strModel)        
        
    end
end

end

