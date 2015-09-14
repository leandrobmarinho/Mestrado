

% max = 10;
% i = 0;
% for j = 1 : 60
%     inds = i + 1 : i + max;
%     
%     imgsDescr = imgsDescrAux(inds);
%     labels = labelsAux(inds);
%     save(sprintf('desc_sift_real_gopro_%.2d', j), 'imgsDescr', 'labels', 'inds');
%     
%     i = i + max;
% end


max = 10;
i = 0;
for j = 1 : 60
    inds = i + 1 : i + max;
    
%     imgsDescr = imgsDescrAux(inds);
    labels = labelsAux(inds);
    save(sprintf('desc_sift_real_gopro_%.2d', j), 'labels', '-append');
    
    i = i + max;
    fprintf('%d \n', j);
end

% 
% p = path;
% path(p, '../');
% 
% folder = '../dados/SIFT_real_gopro/';
% files = dir(sprintf('%s*.mat', folder));
% 
% imgsDescrAux = [];
% labelsAux = [];
% indsAux = [];
% for i = 1 : numel(files)
%     name = files(1).name;
%     load(sprintf('%s%s', folder, name));
%     
%     imgsDescrAux = [imgsDescrAux imgsDescr];
%     labelsAux = [labelsAux labels];
%     indsAux = [indsAux inds];
%     
%     fprintf('%d \n', i);
% end
% 
% path(p)
