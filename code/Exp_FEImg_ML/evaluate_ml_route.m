function [ ] = evaluate_ml_route( dataset, params )


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
    distMLM = {'cityblock', 'euclidean', 'mahalanobis' };
end

if (isfield(params, 'distMLM_NN'))
    distMLM_NN = params.distMLM_NN;
else
    distMLM_NN = {'cityblock', 'euclidean', 'mahalanobis' };
end

descr = params.descr;


% data.x = dataset(:,1:end-1);
% data.y = dataset(:, end);

[data.x, ia, ~] = unique(dataset(:,1:end-1), 'rows');
data.y = dataset(ia, end);

numClass = unique(data.y);
clear dataset ia
if normaliza
    data.x = normalizeData(data.x, 1);
end



%% Shuffle Data
for i = 1 : length(params.routes)
    
    for j = 1 : numRep
        [trainData, testData] = embaralhaDados(data, ptrn, 2);
        dataset{i,j}.train = trainData;
        
        testAux.x = [];
        for k = 1 : length(params.routes{i})
            inds = find(testData.y == params.routes{i}(k));
            
            testAux.x = [testAux.x; testData.x(inds(randperm(length(inds), 1)), :)];
        end
        testAux.y = params.routes{i}';
        dataset{i,j}.test = testAux;
    end
    
end
% save(sprintf('/Users/leandrobm/Downloads/DATA_%s', descr), 'data', 'dataset')
clear trainData testData testAux

%% Evaluate
%% =============== Bayes ===============
if(find(ismember(params.mlMethods,'bayes')))

    config.custo = 1 - eye(length(numClass));
    config.algoritmo = '';
    
    result = simRouteBayes(dataset, config);

    strModel = sprintf('%s_%s_route', descr, 'bayes');   
    save(strModel, 'result', 'config')
    fprintf('%s\n', strModel)
end


% C from LSSVM and SVM
% paraC = 2.^(-3:2:15);
% paraC = 2.^(2:11); %2.^(2:11);
% sigmas = 2.^(0:3); %2.^(-3:3);

paraC = 2.^(-2:2:15);
sigmas = 2.^(-1:4);
%% =============== SVM (Linear) ===============

clear config
if(find(ismember(params.mlMethods,'svmLinear')))

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
    result = simRouteMultiSVM( dataset, optParam);
    
    strModel = sprintf('%s_%s-%s_route', descr, 'svm', config.fkernel);    
    save(strModel, 'result', 'config', 'optParam')
    fprintf('%s\n', strModel)
    
end
   
%% =============== SVM (RBF) ===============
clear config
clear paramsSVM
if(find(ismember(params.mlMethods,'svmRBF')))
    
    config.metodo = 'SMO';    
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
    
    if isfield(params,'extraSVMRBF')
        optParam = params.extraSVMRBF;
    else
        optParam = searchParamSVM(data, paramsSVM, 3, ptrn );
    end
    result = simRouteMultiSVM( dataset, optParam);
            
    strModel = sprintf('%s_%s-%s_route', descr, 'svm', config.fkernel);    
    save(strModel, 'result', 'config', 'optParam')
    fprintf('%s\n', strModel)
    
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

    paramsMLP = 5:5:100;
    
    if isfield(params,'extraMLP')
        optParam = params.extraMLP;
    else
        optParam = searchTopologyMLP(data, paramsMLP, 3, ptrn );
    end
    result = simRouteMLP(dataset, optParam);
    
    strModel = sprintf('%s_%s_route', descr, 'mlp');   
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
    
    if isfield(params,'extraLSSVMLinear')
        optParam = params.extraLSSVMLinear;
    else
        optParam = searchParamSVM(data, paramsSVM, 3, ptrn );
    end
    result = simRouteMultiSVM( dataset, optParam);
    
    strModel = sprintf('%s_%s-%s_route', descr, 'lssvm', config.fkernel);
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
    
    if isfield(params,'extraLSSVMRBF')
        optParam = params.extraLSSVMRBF;
    else
        optParam = searchParamSVM(data, paramsSVM, 3, ptrn );
    end
    result = simRouteMultiSVM( dataset, optParam);
    
    strModel = sprintf('%s_%s-%s_route', descr, 'lssvm', config.fkernel);
    save(strModel, 'result', 'config', 'optParam')
    fprintf('%s\n', strModel)
end




%% =============== Perceptron ===============
if(find(ismember(params.mlMethods,'perceptron')))
    
    if ( size(data.y,2) > 1)
       data.y = vec2ind(data.y')';
    end

    multiperceptron(data.x,data.y, data.x)
    keyboard
end


%% =============== MLM ===============
clear config
if(find(ismember(params.mlMethods,'mlm')))
    
    config.method = ''; % lsqnonlin knn ''
    config.k = 1;
    config.bias = 1;

    
    for dist = distMLM
        
        config.distance = dist{1}; % mahalanobis cityblock ''
        
        result = simRouteMLM(dataset, config);
        
        strModel = sprintf('%s_%s-D-%s-%.0f_route', descr, 'mlm', ...
            config.distance, config.k*100);
        save(strModel, 'result', 'config')
        fprintf('%s\n', strModel)        
        
    end
end



%% =============== MLM-NN ===============
clear config
if(find(ismember(params.mlMethods,'mlmNN')))
    
    config.method = 'knn'; % lsqnonlin knn ''
    config.k = 1;
    config.NN = 1;
    config.bias = 1;
    
    for dist = distMLM_NN
        
        config.distance = dist{1};
        
        result = simRouteMLM(dataset, config);
        
        strModel = sprintf('%s_%s-%d-D-%s-%.0f_route', descr, 'mlmNN', config.NN, ...
        config.distance, config.k*100);
        save(strModel, 'result', 'config')
        fprintf('%s\n', strModel)        
        
    end
end

end

