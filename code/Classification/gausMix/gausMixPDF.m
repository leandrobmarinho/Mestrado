function [ output ] = gausMixPDF( model, data)
%GAUSMIXPDF Summary of this function goes here
%   Detailed explanation goes here

for k = 1 : size(model.means, 1)    
    acumulator(k, :) = model.pi(k)*mvnpdf(data, model.means(k, :), model.covariances(:,:,k))';
end
output = sum(acumulator,1);


