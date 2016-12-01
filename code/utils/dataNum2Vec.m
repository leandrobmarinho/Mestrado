function [ labels ] = dataNum2Vec( labels, numLabels )
%DATANUM2VEC Summary of this function goes here
%   Detailed explanation goes here


code = zeros(length(numLabels), length(numLabels));
for c = 1: length(numLabels),
    code(c, c) = 1;
end
for c = length(numLabels):-1:1,
    ind = (labels == numLabels(c));
    tam = length(find(ind==1));
    labels_y(ind, :) = repmat(code(c, :), tam, 1);
end
labels = labels_y;

end

