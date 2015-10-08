function [result, times] = multiperceptron(TrainingSet,GroupTrain,TestSet)

% TrainingSet = [0 0 1 1; 0 1 0 1]';
% GroupTrain = [0 1 1 1]';
% TestSet  = TrainingSet;

u=unique(GroupTrain);
numClasses=length(u);
result = zeros(length(TestSet(:,1)),1);

tic
%build models
for k=1:numClasses
    %Vectorized statement that binarizes Group
    %where 1 is the current class and 0 is all other classes
    G1vAll=(GroupTrain==u(k));
%     models(k) = svmtrain(TrainingSet,G1vAll);
        

    net = perceptron;
    net.trainParam.showWindow = 0;
    net.trainParam.epochs = 10;
    models{k} = train(net, TrainingSet', G1vAll');
           
end
times.trein = toc;


tic
%classify test cases
for j=1:size(TestSet,1)
    for k=1:numClasses
        model = models{k};
        
        y = model(TestSet(j));
        if isnan(y)
            y = false;
        end
        if(y)
            break;
        end
    end
    result(j) = k;
end
times.test = toc;