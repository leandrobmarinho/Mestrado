% close all; clear all; clc

% fprintf('%2.4f %2.4f\n', mean(elm), std(elm))
% fprintf('%2.4f %2.4f\n', mean(rbf), std(rbf))
% fprintf('%2.4f %2.4f\n', mean(mlp), std(mlp))
% fprintf('%2.4f %2.4f\n', mean(mlmE), std(mlmE))
% fprintf('%2.4f %2.4f\n', mean(mlm), std(mlm))



valores = [];
rotulos = [];
for i = 1:10
    rotulos = [rotulos; 'MLM-E ']
end
for i = 1:10
    rotulos = [rotulos; 'MLM-M ']
end
for i = 1:10
    rotulos = [rotulos; 'MLM-NN']
end

for i = 1:10
    rotulos = [rotulos; 'ELM   ']
end
for i = 1:10
    rotulos = [rotulos; 'RBF   ']
end
for i = 1:10
    rotulos = [rotulos; 'MLP   ']
end

valores = [mlmE mlm mlm9 elm rbf mlp];


boxplot(valores', rotulos, 'labelorientation', 'inline')
ylabel('Taxa de Acerto', 'FontSize', 12)
xlabel('Métodos', 'FontSize', 12)