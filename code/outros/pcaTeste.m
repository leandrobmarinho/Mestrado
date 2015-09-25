close all, clear all, clc

A = [269.8 38.9 50.5
272.4 39.5 50.0
270.0 38.9 50.5
272.0 39.3 50.2
269.8 38.9 50.5
268.2 38.6 50.2
268.2 38.6 50.8
267.0 38.2 51.1
267.8 38.4 51.0
273.6 39.6 50.0
271.2 39.1 50.4
269.8 38.9 50.5
270.0 38.9 50.5
];

A = A(:, [2 3 1])

[n m] = size(A)
AMean = mean(A)
AStd = std(A)
B = (A - repmat(AMean,[n 1])) ./ repmat(AStd,[n 1]);
% B = zscore(A)
% [V D] = eig(cov(B))
% diag(D)
[COEFF SCORE LATENT] = princomp(B)
% B * COEFF
% (B * COEFF) * COEFF'
% ((B * COEFF) * COEFF') .* repmat(AStd,[n 1]) + repmat(AMean,[n 1])
% cumsum(var(SCORE)) / sum(var(SCORE))


% load fisheriris
% X = meas;
% X = bsxfun(@minus, X, mean(X));    % zero-centered data
X = B;
[~,S,V] = svd(X,0);                % singular value decomposition


S
[S,ord] = sort(diag(S), 'descend');
pc = V(:,ord);                    % principle components
latent = S.^2 ./ (size(X,1)-1);    % variance explained
score = X*pc;                     % projected data

pc

% [U,Sigma,V] = svd(X,'econ');  % Always use economy SVD option to
                       % prevent possible massive unneeded computation.
                       
% Sigma
% s = diag(Sigma); % Vector of singular values

% Plot cumulative variance explained by first k modes

% normsqS = sum(s.^2);
% cumsum(s.^2)/normsqS

cumsum(latent)./sum(latent)


% load hald
% ingredients = ingredients(:, [4 3 2 1]);
% covx = cov(ingredients)
% [COEFF,latent,explained] = pcacov(covx);



[V E] = eig( cov(X) );
[E order] = sort(diag(E), 'descend');
V = V(:,order);
latent = E.^2 ./ (size(X,1)-1);
cumsum(latent)./sum(latent)