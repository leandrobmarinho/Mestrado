function [classes, output] = testePerceptron(modelo, dados)

%keyboard
lin = size(dados.x, 1);
X = [ones(lin, 1) dados.x];
Y = dados.y;


output = X*modelo.W';

% if (size(Y,2) > 2)
%     %Multi-Classes
%     [~, index] = max(Yh');
%     [~, target] = max(Y');
%     erro = length(find(index ~= target))/lin;
% else
%     %2 Classes
%     erro = sum(sign(Yh) ~= Y)/lin;
% end


if (size(Y,2) > 2)
    %Multi-Classes
    
    [output, classes] = max(output');
else
    
    %2 Classes
    classes = sign(output);
end

end