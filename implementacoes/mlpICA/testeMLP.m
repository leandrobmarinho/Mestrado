function [output] = testeMLP(model, data)
% var L denotes the number of hidden units
% var data encompass inputs and outputs

% keyboard
X = data.x;
Y = data.y;
N = size(data.x, 1);
D = size(data.x, 2);

H = [ones(N, 1) X]*model.W';
H = tanh(H);
H = [ones(N, 1) H];

O = H*model.M';
O = tanh(O);

    
if (size(Y,2) > 2)
    
    %Multi-Classes
    [~, output] = max(O');
    
%     tam = size(Y,2);
%     code = zeros(tam, tam);
%     for j = 1: tam,
%         code(j, j) = 1;
%     end
%     [~, pos] = sort(pdist2(O, code)');
%     sum(pos(1,:) == output)/size(data.x, 1)
else
    %2 Classes
    output = sign(O);
end
    
end


