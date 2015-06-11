function [ metricas, metricasGeral ] = metricasMatConf( matriz )
%METRICASMATCONF Summary of this function goes here
%   Detailed explanation goes here
%   metricas [spe sens ppv fscore hm acc; ...]
%   metricasGeral [spe sens ppv fscore hm acc; ...] (media ponderadada das metricas)

for c = 1 : size(matriz,2)
    TP = matriz(c,c);
    TN = trace(matriz())- TP;
    FP = sum(matriz(:,c)) - TP;
    FN = sum(matriz(c,:)) - TP;
%     FN = sum(sum(matriz)) - TN - TP - FP;
    
    metricas(c,1) = ( TN ) / ( TN + FP ); %spe
    metricas(c,2) = ( TP ) / ( TP + FN ); %sens
    metricas(c,3) = ( TP ) / ( TP + FP ); %ppv
    metricas(c,4) = ( 2*metricas(c,3)*metricas(c,2)) / ....
        (metricas(c,3) + metricas(c,2)); %fscore
    metricas(c,5) = ( 2*metricas(c,2)*metricas(c,1)) / ...
        (metricas(c,2) + metricas(c,1)); %hm
    metricas(c,6) = TP/sum(matriz(c,:)); %acc
        
end

metricasGeral = sum(metricas.*repmat(sum(matriz,2), 1, size(metricas,2)))...
    ./repmat(sum(sum(matriz,2)), 1, size(metricas,2));

end

