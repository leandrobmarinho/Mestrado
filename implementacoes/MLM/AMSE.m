function [amse] =  AMSE(data, model, conf)
    if(strcmpi(conf.option, 'distances'))
                
        switch (model.distance)
            case ('mahalanobis')
                DX = pdist2(data.x, model.refX, 'mahalanobis', model.covX);
                DY = pdist2(data.y, model.refY, 'mahalanobis', model.covX);
                
            case ('cityblock')
                DX = pdist2(data.x, model.refX, 'cityblock');
                DY = pdist2(data.y, model.refY, 'cityblock');
                
            otherwise
                DX = pdist2(data.x, model.refX);
                DY = pdist2(data.y, model.refY);
                
        end        
        
        if(model.bias == 1),
            DX = [ones(size(data.x, 1), 1) DX];
        end
        DYh = DX*model.B;        
                        
        errors = (DY - DYh);
    else
        [~, errors] = test_MLM(model, data, conf);
    end
    amse = mean(mean(errors.^2));
    
end