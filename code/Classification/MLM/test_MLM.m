function [Yh, error, output] =  test_MLM(model, data, conf)

switch (model.distance)
    case ('mahalanobis')
        DX = pdist2(data.x, model.refX, 'mahalanobis', model.covX);
        
    case ('cityblock')
        DX = pdist2(data.x, model.refX, 'cityblock');
        
    case ('euclidean')
        DX = pdist2(data.x, model.refX);
end


if(model.bias == 1),
    DX = [ones(size(data.x, 1), 1) DX];
end
DYh = DX*model.B; % Estimates for the output distances

% Options for the optimization methods
options_fsolve = optimset('Display', 'off', 'Algorithm','levenberg-marquardt', 'FunValCheck', 'on', 'TolFun', 10e-6 );
options_lsq = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt', 'Jacobian','on', 'FunValCheck', 'on', 'Display', 'off' );

Yh = zeros(size(data.x, 1), size(model.refY, 2));
yh0 = mean(model.refY); % initial estimate for y

try
    switch (conf.method)
        
        
        case ('lsqnonlin')
            for i = 1: size(data.x, 1),
                Yh(i, :) = lsqnonlin(@(x)(fun(x, model.refY, DYh(i, :))), yh0, [], [], options_lsq);
            end
        case ('knn')
            [~, Ind] = sort(DYh, 2);
            %         for i = 1: size(data.x, 1),
            %             Yh(i,:) = mode(model.refY(Ind(i, 1:conf.NN), :));
            %         end
            
            
            labels = vec2ind(model.refY')';
            n = size(data.x, 1);
            
            if (conf.NN > 1)
                Yh = mode(reshape(labels(Ind(:, 1:conf.NN)', :), conf.NN, n))';
            else
                Yh = labels(Ind(:, 1:conf.NN)', :);
            end
            
            
            Yh = full(ind2vec(Yh'))';
            
            output = unique(labels(Ind)', 'rows', 'stable');
            
            
            %         labels = unique(y);
            %         code = zeros(length(labels), length(labels));
            %         for j = 1: length(labels),
            %             code(j, j) = 1;
            %         end
            %
            %         for j = length(labels):-1:1,
            %             ind = (y == labels(j));
            %             tam = length(find(ind==1));
            %             Yh(ind, :) = repmat(code(j, :), tam, 1);
            %         end
            
        otherwise
            
            for i = 1: size(data.x, 1),
                Yh(i, :) = fsolve(@(x)(sum((model.refY - repmat(x, length(model.refY), 1)).^2, 2) - DYh(i,:)'.^2), yh0, options_fsolve);
            end           
            
            [~, output] = sort(Yh', 'descend');

    end

catch
    warning('It was not possible classify!!!');
end

error = [];
if(isempty(data.y) == 0 && size(data.y,2) == size(Yh,2))
    error = data.y - Yh;
end

