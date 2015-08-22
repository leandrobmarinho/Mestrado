function [ imEq ] = histeq2( img )
%HISTEQ2 Summary of this function goes here
%   Detailed explanation goes here


%Encontra o histograma da imagem
histImg = imhist(img);
bin = length(histImg)-1;

%Dividide o resultado pelo número de pixels
output = histImg/numel(img);


%Calcula a soma acumulada
CSum = cumsum(output);



%Realiza a transformacao S=T(R)
imEq = CSum(img+1);


%Converte a imagem em uint8
imEq = uint8(imEq*bin);

end

