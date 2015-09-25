classdef DataSet < handle
   
   properties
     data % dataset
     features % features of the data
     labels  % labels of the data
   end
   
   methods
       function obj = DataSet(path)
         obj.data = load(path);
         tam = size(obj.data,2);  
         obj.features = obj.data(:,(1:tam - 1));
         obj.labels = obj.data(:,(tam : tam));
       end    
       
       function normalize(obj)
         obj.features = (obj.features - repmat(mean(obj.features),size(obj.features,1),1))./repmat(std(obj.features),size(obj.features,1),1);
         tam = size(obj.data,2);  
         obj.labels = obj.data(:,(tam : tam));
         obj.data = [obj.features obj.labels];
       end
       
       function [train_features train_labels test_features test_labels] = shuffle(obj, train_percs)
        % make training and testing datasets
        pattern_number = size(obj.features,1);
        shuffle_inds = randperm(pattern_number);
        shuffle_train_inds = shuffle_inds(1,round(1:pattern_number*train_percs/100));
        shuffle_test_inds = shuffle_inds(1,round(pattern_number*train_percs/100 + 1:pattern_number));
        % train features and labels
        train_features = obj.features(shuffle_train_inds,:);
        train_labels = obj.labels(shuffle_train_inds,:);        
        % test features and labels
        test_features  = obj.features(shuffle_test_inds,:);
        test_labels  = obj.labels(shuffle_test_inds,:);
       end

       function [features labels] = shuffleDataset(obj)
        % make training and testing datasets
        pattern_number = size(obj.features,1);
        shuffle_inds = randperm(pattern_number);
        % data features and labels
        features = obj.features(shuffle_inds,:);
        labels = obj.labels(shuffle_inds,:);        
       end
       
       function [sizee] = sizeDataset(obj)
         sizee = size(obj.features,1);
       end    
       
       
   end    
   
   
   
end