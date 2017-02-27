function conf  = loadParamSCM( conf, camera, type )
%LOADPARAM Summary of this function goes here
%   Detailed explanation goes here

load(sprintf('scm_%s_%s_real_svm-linear.mat', type, camera));
conf.extraSVMLinear.metodo = 'SMO';
conf.extraSVMLinear.options.MaxIter = 9000000;
conf.extraSVMLinear.fkernel = 'linear';
conf.extraSVMLinear.paraC = optParam.paraC;

load(sprintf('scm_%s_%s_real_svm-rbf.mat', type, camera));
conf.extraSVMRBF.metodo = 'SMO';
conf.extraSVMRBF.options.MaxIter = 9000000;
conf.extraSVMRBF.fkernel = 'rbf';
conf.extraSVMRBF.paraC = optParam.paraC;
conf.extraSVMRBF.sigma = optParam.sigma;


load(sprintf('scm_%s_%s_real_mlp.mat', type, camera));
conf.extraMLP = optParam;

end

