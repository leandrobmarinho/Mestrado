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
else
    %2 Classes
    output = sign(O);
end
    
end


