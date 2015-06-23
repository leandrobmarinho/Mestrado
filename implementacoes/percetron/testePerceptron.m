function [output] = testePerceptron(modelo, dados)

%keyboard
lin = size(dados.x, 1);
X = [ones(lin, 1) dados.x];
Y = dados.y;


Yh = X*modelo.W';

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
    
    [~, output] = max(Yh');
else
    
    %2 Classes
    output = sign(Yh);
end

end