function [ output ] = fdpGaus( dados, media, covar )
%FDPGAUS Summary of this function goes here
%   Detailed explanation goes here

dados = dados';
media = media';

output = (1 /( ((2*pi)^(size(dados,1)/2))*det(covar)^0.5 ) )...
    *exp( -1/2 * diag(( (dados - repmat(media, 1, size(dados,2)))'*...
    inv(covar)*(dados - repmat(media, 1, size(dados,2))) ) ));
output = output';


% output = (- size(dados,1)/2 * log(2*pi)) - 1/2*log(det(covar)) ...
%     - 1/2*diag((dados - repmat(media, 1, size(dados,2)))'*...
%     inv(covar)*(dados - repmat(media, 1, size(dados,2))));
% output = output';

% for i = 1 : size(dados,1)
%     output(i) = (1 /( ((2*pi)^(size(dados,2)/2))*det(covar)^0.5 ) )...
%         *exp( -1/2 * ( (dados(i,:) - media)*inv(covar)*(dados(i,:) - media)' ) );    
% end

% for i = 1 : size(dados,1)
% output2(i) = (- size(dados,2)/2 * log(2*pi)) - 1/2*log(det(covar)) - 1/2* ...
%     (dados(i, :) - media)*inv(covar)*(dados(i, :) - media)';
% end


end