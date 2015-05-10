function [ output ] = testeSOM_KNN(modelo, dados)

if (size(modelo.W, 1) == 1)
    output = repmat(modelo.Wy, size(dados.x, 1), 1);
else
    dist = pdist2(modelo.W, dados.x);
    [~, posicoes] = sort(dist);
    
    
%     output = modelo.Wy(posicoes(1,:));
%     output =  mode(modelo.Wy(posicoes(1:modelo.K,:)))';
    
    for i = 1 : size(dados.x, 1)
        %Se tentar pegar mais neuronios que existe
        if (modelo.K > size(modelo.W, 1))
            modelo.K = size(modelo.W, 1); 
        end
        
        y = modelo.Wy(posicoes(1:modelo.K, i));
        
        U = unique(y);
        H = histc(y,U);
        
        if (length(U(H==max(H))) == 1)
            output(i) = U(H==max(H));
        else
            output(i) = 0;
        end
    end
    output = output';
    
end

end

