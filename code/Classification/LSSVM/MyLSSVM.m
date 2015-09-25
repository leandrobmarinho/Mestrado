classdef MyLSSVM < handle
    
   properties
      train_features % features of training dataset
      train_labels % labels of training dataset
      gamma % trade-off between hit and error costs
      bias % bias of LSSVM classifier
      alphas % Lagrange multipliers of LSSVM classifier
      sigma % Sigma of RBF kernel
   end
   
   methods
      function obj = MyLSSVM(train_features, train_labels, params)
         obj.train_features = train_features;
         obj.train_labels = train_labels;
         obj.gamma = params.gamma;
         obj.bias = [];
         obj.alphas = [];
         if (isfield(params, 'sigma'))
             obj.sigma = params.sigma;
         end
      end
      
      function train(obj)
        % getting A.x = b problem
        A = (obj.train_features*obj.train_features').*(obj.train_labels*obj.train_labels');
        A = A + (1/obj.gamma)*eye(size(obj.train_features,1));
        A = [obj.train_labels'; A];
        A = [[0; obj.train_labels] A];
        aux = ones(size(obj.train_features,1),1);
        b = [0; aux];
        clear aux;

        % make lssvm classifier
        x = A\b;
        %bias = [x(1,1)];
        %alphas = [x(2:size(obj.train_features,1) + 1 ,1)];
        obj.bias = [x(1,1)];
        obj.alphas = [x(2:size(obj.train_features,1) + 1 ,1)];
      end
      
      function [class, real] = classify(obj,test_features)
        %make decision function
        
        if (isempty(obj.sigma) == 0) % kernel rbf
            K = pdist2(test_features, obj.train_features);
            K = exp(-(K.^2)/obj.sigma^2);
            
            real = sum(K.*repmat(obj.alphas'.*obj.train_labels',size(test_features,1),1),2) + obj.bias;
            class = sign(sum(K.*repmat(obj.alphas'.*obj.train_labels',size(test_features,1),1),2) + obj.bias);            
        else
            
            % sem kernel
            real = sum(test_features*obj.train_features'.*repmat(obj.alphas'.*obj.train_labels',size(test_features,1),1),2) + obj.bias;
            class = sign(sum(test_features*obj.train_features'.*repmat(obj.alphas'.*obj.train_labels',size(test_features,1),1),2) + obj.bias);
            
        end
      end
      
   end % methods
end % classdef 