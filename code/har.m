close all; clear all; clc;

x = load('dados/HAR/train/X_train.txt');
x = [x; load('dados/HAR/test/X_test.txt')];
y = load('dados/HAR/train/Y_train.txt');
y = [y; load('dados/HAR/test/Y_test.txt')];

classes = unique(y);

resultados = [];
for i = 1 : length(classes)
    
    indx = find(y == classes(i));
    
    
    for j = 1 : size(x,2)
        resultados(j,i) = mean(x(indx, j));
        
        resultados(j, 14) = mean(x(:, j));
    end
    
    for j = 1 : size(x,2)
        resultados(j, (i+length(classes)) ) = var(x(indx, j));
        
        resultados(j, 13) = var(x(:, j));
    end    
end

varClass = var(resultados(:, [1:6])')';
varClass = [varClass var(resultados(:, [7:12])')'];

[v, pos] = sort(varClass(:,1), 'descend');
% [~, pos] = sort(varClass, 'descend');

%% Variancias por classe
% plot([1:1:561], resultados(:, 7), '-og' )
% hold on
% plot([1:1:561], resultados(:, 8), '-ob' )
% hold on
% plot([1:1:561], resultados(:, 9), '-oc' )
% hold on
% plot([1:1:561], resultados(:, 10), '-or' )
% hold on
% plot([1:1:561], resultados(:, 11), '-ok' )
% hold on
% plot([1:1:561], resultados(:, 11), '-om' )
% hold on
plot([1:1:561], resultados(:, 12), '--ob' )

figure
%% Medias por classe
% plot([1:1:561], resultados(:, 1), '-og' )
% hold on
% plot([1:1:561], resultados(:, 2), '-ob' )
% hold on
% plot([1:1:561], resultados(:, 3), '-oc' )
% hold on
% plot([1:1:561], resultados(:, 4), '-or' )
% hold on
% plot([1:1:561], resultados(:, 5), '-ok' )
% hold on
% plot([1:1:561], resultados(:, 6), '-om' )
% hold on
% plot([1:1:561], resultados(:, 14), '--oy' )