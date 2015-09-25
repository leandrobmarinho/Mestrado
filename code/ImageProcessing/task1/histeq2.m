function [ imEq ] = histeq2( imgIn )
%HISTEQ2 Summary of this function goes here
%   Detailed explanation goes here


%Encontra o histograma da imagem
histImg = imhist2(imgIn);
bin = length(histImg)-1;

%Dividide o resultado pelo número de pixels
output = histImg/numel(imgIn);


%Calcula a soma acumulada
CSum = cumsum(output);



%Realiza a transformacao S=T(R)
imEq = CSum(imgIn+1);


%Converte a imagem em uint8
imEq = uint8(imEq*bin);

end

