clear; close all; clc;

folder = 'omni/modelos_teste_navegacao/';
files = dir(sprintf('%s*.mat', folder));

name = {files.name};
[~, index] = sort(name);
namesFile = name(index);

values = zeros(numel(files), 1);
for i = 1 : numel(files)
    
    name = namesFile{i};
    load(sprintf('%s%s', folder, name));
    
    fprintf('%s\n', name)
    
    s = whos('model');
    try
        values(i) = s.bytes;
    catch e
        
    end
    clear s model

end

values = reshape(values, 12, 5);
values = values./1024;
fprintf([repmat('%.2f\t', 1, size(values, 2)) '\n'], values')