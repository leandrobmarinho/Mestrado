function [ conf ] = loadParam0( extrat_name, camera, conf )
%LOADPARA Summary of this function goes here
%   Detailed explanation goes here

folder = 'temp/';
files = dir(sprintf('%s*.mat', folder));

name = {files.name};
[~, index] = sort(name);
namesFile = name(index);

for i = 1 : numel(files)
    name = namesFile{i};
    load(sprintf('%s%s', folder, name));
    
    if(not(isempty(strfind(name, extrat_name))) && not(isempty(strfind(name, camera))))
        if(not(isempty(strfind(name, 'lssvm-linear'))))
            conf.extraLSSVMLinear.metodo = 'LS';
            conf.extraLSSVMLinear.options.MaxIter = 9000000;
            conf.extraLSSVMLinear.fkernel = 'linear';
            conf.extraLSSVMLinear.paraC = optParam.paraC;
            
        elseif (not(isempty(strfind(name, 'lssvm-rbf'))))
            conf.extraLSSVMRBF.metodo = 'LS';
            conf.extraLSSVMRBF.options.MaxIter = 9000000;
            conf.extraLSSVMRBF.fkernel = 'rbf';
            conf.extraLSSVMRBF.paraC = optParam.paraC;
            conf.extraLSSVMRBF.sigma = optParam.sigma;
            
        elseif (not(isempty(strfind(name, 'mlp'))))
            conf.extraMLP = optParam;
            
        elseif (not(isempty(strfind(name, 'svm-linear'))))
            conf.extraSVMLinear.metodo = 'SMO';
            conf.extraSVMLinear.options.MaxIter = 9000000;
            conf.extraSVMLinear.fkernel = 'linear';
            conf.extraSVMLinear.paraC = optParam.paraC;
            
        elseif (not(isempty(strfind(name, 'svm-rbf'))))
            conf.extraSVMRBF.metodo = 'SMO';
            conf.extraSVMRBF.options.MaxIter = 9000000;
            conf.extraSVMRBF.fkernel = 'rbf';
            conf.extraSVMRBF.paraC = optParam.paraC;
            conf.extraSVMRBF.sigma = optParam.sigma;
        end
        
    end
end

end

