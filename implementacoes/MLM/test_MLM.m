function [Yh, error] =  test_MLM(model, data, conf)

switch (model.distance)
    case ('mahalanobis')
        DX = pdist2(data.x, model.refX, 'mahalanobis', model.covX);
        
    case ('cityblock')
        DX = pdist2(data.x, model.refX, 'cityblock');
        
    otherwise
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
        Yh = mode(reshape(labels(Ind(:, 1:conf.NN)', :), conf.NN, n))';
        Yh = full(ind2vec(Yh'))';
        
    otherwise
        for i = 1: size(data.x, 1),
            Yh(i, :) = fsolve(@(x)(sum((model.refY - repmat(x, length(model.refY), 1)).^2, 2) - DYh(i,:)'.^2), yh0, options_fsolve);
        end
end


error = [];
if(isempty(data.y) == 0)
    error = data.y - Yh;
end

