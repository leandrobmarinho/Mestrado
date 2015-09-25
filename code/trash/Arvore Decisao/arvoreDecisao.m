function [ output ] = arvoreDecisao( dataset)
% 1 C. sepal
% 2 L. sepal
% 3 C. petal
% 4 L. petal

% 1 0 0 Iris Setosa
% 0 1 0 Iris Versicolour
% 0 0 1 Iris Virginica

[N, ~] = size(dataset);

for i = 1 : N,
    amostra = dataset(i,:);
    
    
    %% Regras
    
    % Primeira árvore
    if (amostra(3) < 2.3)
        output(i) = 1;
    else
        if(amostra(4) >= 1.75)
            output(i) = 3;
        else
            if(amostra(3) >= 4.95)
                output(i) = 3;
            else
                if(amostra(4) >= 1.65)
                    output(i) = 3;
                else
                    output(i) = 2;
                end
                
                % Outra possibilidade de subárvore
                % classe(i) = 2;
            end
        end
    end
    
    
    % Segunda árvore
%     if (amostra(3) < 2.3)
%         classe(i) = 1;
%     else
%         if(amostra(3) < 4.75)
%             classe(i) = 2;
%         else
%             if(amostra(3) >= 5.05)
%                 classe(i) = 3;
%             else
%                 if(amostra(1) >= 6.5)
%                     classe(i) = 2;
%                 else
%                     if(amostra(2) >= 3.1)
%                         classe(i) = 2;
%                     else
%                         classe(i) = 3;
%                     end
%                 end
%                 
%             end
%         end
%     end
    

end

end

