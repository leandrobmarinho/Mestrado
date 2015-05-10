function [model] = treinoMLP(data, conf)
% var L denotes the number of hidden units
% var data encompass inputs and outputs
X = data.x;
Y = data.y;
C = size(Y, 2);
d = size(X, 2);  N = size(X,1);
X = [ones(N, 1) X]; % adding the bias term
W = rand(conf.L, d+1); % weights between in-hidden layers
M = rand(C, conf.L+1); % weights between hidden-out layers

for iteration = 1: conf.maxIterations,
    fprintf('Treinando MLP. Época %d\n', iteration);
    
    for i = 1: N,
        x = X(i,:);
        y = Y(i,:);
        
        %% forward step
        h = x*W';
        h = tanh(h);
        h = [1 h]; % adding the bias term

        o = h*M'; % o stands for output
        o = tanh(o);       
    
 %       auxMSE(i) = sum((y - yh).^2);
        
 %       [~, indTarget] = max(y);
 %       [~, indEstimated] = max(yh);
        
 %       auxSuccessRate(i) = 0;
 %       if(indTarget~=indEstimated),
 %           auxSuccessRate(i) = 1;
%        end
        %% backward step - error backpropagation
        error = y - o;
        for c = 1: C,
            lGrad2(c) = -error(c)*(1 - o(c)^2);
        end
        M = M - conf.lRate*lGrad2'*h;
        
        for l=1:conf.L,
            aux = 0;
            for c=1: C,
                aux = aux + lGrad2(c)*M(c, l);
            end
            lGrad1(l) = (1 - h(l)^2)*aux;
        end
        W = W - conf.lRate*lGrad1'*x;
    end
%    MSE(iteration) = mean(auxMSE);
%    Accuracy(iteration) = mean(auxSuccessRate);
    ind = randperm(N);
    X = X(ind, :);
    Y = Y(ind, :);
end

model.W = W;
model.M = M;
