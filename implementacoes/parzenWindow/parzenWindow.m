function [ output ] = parzenWindow( teste, dados, h)
%PARZENWINDOW Summary of this function goes here
%   Detailed explanation goes here

[N, l] = size(dados);

for i = 1 : size(teste,1)

output(i) = sum( (1 / ( (2*pi)^(l/2) )*h^l ) * exp( - ...
    diag( (dados - repmat(teste(i,:), N, 1)) * ...
    (dados - repmat(teste(i,:), N, 1))') ./ (2 * h^2 ) ) ) / N;

end


end