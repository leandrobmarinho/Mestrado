function [ output ] = arvoreDecisao( dataset)
% 1 C. sepal
% 2 L. sepal
% 3 C. petal
% 4 L. petal

% 1 0 0 Iris Setosa
% 0 1 0 Iris Versicolour
% 0 0 1 Iris Virginica

[N, ~] = size(dataset);

numClass = 3;
output = [];
for i = 1 : N,
    amostra = dataset(i,:);
    classe = zeros(1, numClass);
    
    
    %% Regras
    
    % Primeira árvore
    if (amostra(3) < 2.3)
        classe(1) = 1;
    else
        if(amostra(4) >= 1.75)
            classe(3) = 1;
        else
            if(amostra(3) >= 4.95)
                classe(3) = 1;
            else
                if(amostra(4) >= 1.65)
                    classe(3) = 1;
                else
                    classe(2) = 1;
                end
                
                % Outra possibilidade de subárvore
                % classe(2) = 1;
            end
        end
    end
    
    
    % Segunda árvore
%     if (amostra(3) < 2.3)
%         classe(1) = 1;
%     else
%         if(amostra(3) < 4.75)
%             classe(2) = 1;
%         else
%             if(amostra(3) >= 5.05)
%                 classe(3) = 1;
%             else
%                 if(amostra(1) >= 6.5)
%                     classe(2) = 1;
%                 else
%                     if(amostra(2) >= 3.1)
%                         classe(2) = 1;
%                     else
%                         classe(3) = 1;
%                     end
%                 end
%                 
%             end
%         end
%     end
    
    
    
    output = [output; classe];
end

end

