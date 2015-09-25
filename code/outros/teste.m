close all; clear ; clc

% number of training samples to generate.
nsamples = 20;
 
% create some training data for three classes.
training = cell(3,1);
training{1} = randn(nsamples,2) + repmat([-2 -2], [nsamples 1]);
training{2} = randn(nsamples,2) + repmat([2 3], [nsamples 1]);
training{3} = randn(nsamples,2) + repmat([-3 2], [nsamples 1]);
 
% sample mean
sample_means = cell(length(training),1);
 
% compute sample mean to use as the class prototype.
for i=1:length(training),
    sample_means{i} = mean(training{i});
end

% intervalo da fronteira
xrange = [-8 8];
yrange = [-8 8];
% intervalo do incremento
inc = 1;
 
% gera a grade de coordenadas
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
 
xy = [x(:) y(:)];

% size of the (x, y) image, which will also be the size of the 
% decision boundary image that is used as the plot background.
image_size = size(x);

numxypairs = length(xy); % number of (x,y) pairs
 
% distance measure evaluations for each (x,y) pair.
dist = [];
 
% loop through each class and calculate distance measure for each (x,y)
% from the class prototype.
for i=1:length(training),
 
    % calculate the city block distance between every (x,y) pair and
    % the sample mean of the class.
    % the sum is over the columns to produce a distance for each (x,y)
    % pair.
    disttemp = sum(abs(xy - repmat(sample_means{i}, [numxypairs 1])), 2);
 
    % concatenate the calculated distances.
    dist = [dist disttemp];
 
end
 
% for each (x,y) pair, find the class that has the smallest distance.
% this will be the min along the 2nd dimension.
[m,idx] = min(dist, [], 2);

% reshape the idx (which contains the class label) into an image.
decisionmap = reshape(idx, image_size);


figure;
 
%show the image
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');
 
% colormap for the classes:
% class 1 = light red, 2 = light green, 3 = light blue
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1]
colormap(cmap);
 
% plot the class training data.
plot(training{1}(:,1),training{1}(:,2), 'r.');
plot(training{2}(:,1),training{2}(:,2), 'go');
plot(training{3}(:,1),training{3}(:,2), 'b*');
 
% include legend
legend('Class 1', 'Class 2', 'Class 3','Location','NorthOutside', ...
    'Orientation', 'horizontal');
 
% label the axes.
xlabel('x');
ylabel('y');


% ind1 = find( (xy(:,1) + xy(:,2) > 7) == 1)
% ind2 = find( (xy(:,1) + xy(:,2) > 7) == 0)
% 
% cmap = hsv(2);
% plot(xy(ind1,1), xy(ind1,2),'o','Color', cmap(1,:));
% hold on
% plot(xy(ind2,1), xy(ind2,2),'o','Color', cmap(2,:));
% hold on

% for i = 1:2     %# Loop 6 times
%     plot(xy(ind1,1), xy(ind2,2),'o','Color', cmap(i,:));  %# Plot each column with a
%     hold on;
% end

% cmap = hsv(3);
% indx = find( [1 0 0] * testData.y')
% indx1 = find( [1 0 0] * testData.y')
% indx2 = find( [0 1 0] * testData.y')
% indx3 = find( [0 0 1] * testData.y')
% plot(testData.x(indx1,1), testData.x(indx1,2), 'o', 'Color', cmap(1,:))
% hold on
% plot(testData.x(indx2,1), testData.x(indx2,2), 'o', 'Color', cmap(2,:))
% hold on
% plot(testData.x(indx3,1), testData.x(indx3,2), 'o', 'Color', cmap(3,:))