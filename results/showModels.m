clear; close all; clc;

folder = 'gopro/modelos_teste_navegacao/';
files = dir(sprintf('%s*.mat', folder));

name = {files.name};
[~, index] = sort(name);
namesFile = name(index);

values = zeros(numel(files), 1);
for i = 1 : numel(files)
    
    name = namesFile{i};
    load(sprintf('%s%s', folder, name));
    
    fprintf('%s\n', name)    
    
    if (not(isempty(strfind(name, 'mlp'))))
        IW = cell2mat(model.IW);
        LW = cell2mat(model.LW);
        b = cell2mat(model.b);
        clear model
        model.IW = IW;
        model.LW = LW;
        model.b = b;
    end
    
    
    s = whos('model');
    try
        values(i) = s.bytes;
    catch e
        
    end
    clear s model
    
end

values = reshape(values, 12, 5);
values = values./1024;
values = values(:, [5 1 3 2 4]);
fprintf([repmat('%.2f\t', 1, size(values, 2)) '\n'], values')
