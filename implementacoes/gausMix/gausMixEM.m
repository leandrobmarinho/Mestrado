function [ model ] = gausMixEM( data, conf )
%TRAINGAUSMIX Summary of this function goes here
%   Detailed explanation goes here


%% Inicializa os parametros
resultKMeans = trainKMeans(data, conf);
means = resultKMeans.prototypes;
for i = 1 : conf.k
    covariances(:, :, i) = cov(resultKMeans.data.x(resultKMeans.data.y == i, :));
    pi_s(i) = sum(resultKMeans.data.y == i) / size(resultKMeans.data.x, 1);
end

if(conf.k == 1)
    model.covariances = covariances;
    model.means = means;
    model.pi = pi_s;
    return;
end
N = size(data,1);
p = size(data,2);

% Ate covergir
for epoca = 1 : conf.epocas
    % Avalia o log da verossimilhanca
    for k = 1 : conf.k
        acumulator(k, :) = (pi_s(k)*mvnpdf(data, means(k,:), covariances(:,:,k)));
    end
    logLikelihood = sum(log(sum(acumulator)));
    
%     fprintf('Erro %f \n', sum(log(sum(acumulator))) );
    
    if ( epoca > 1 && (logLikelihood <= conf.threshold || ...
            oldLogLike == logLikelihood ) )
        fprintf('Convergiu na época %d. %f\n', epoca, logLikelihood);
        break;
    end
    oldLogLike = logLikelihood;
    
    %Para cada componente k
    for k = 1 : conf.k
        %% Passo E
        respons = pi_s(k)*mvnpdf(data, means(k,:), covariances(:,:,k))'...
            ./sum(acumulator);
        
        %% Passo M
        means(k,:) = sum(data.*repmat(respons', 1, p))...
            ./repmat(sum(respons), 1, p);
        
        covariances(:,:,k) = ( ( (repmat(respons, p, 1) ).*...
            (data - repmat(means(k,:), N, 1))')...
            * (data - repmat(means(k,:), N, 1)) )...
            ./repmat(sum(respons), p, p);
        
        pi_s(k) = sum(respons)/N;
    end
    
end

model.covariances = covariances;
model.means = means;
model.pi = pi_s;

end

