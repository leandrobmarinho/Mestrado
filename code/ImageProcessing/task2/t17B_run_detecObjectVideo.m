clear; close all; clc
p = path; path(p, '../task1')

%% Desconecta e remove todas os objetos de aquisição de imagem
imaqreset

%% Desativa as mensagens para o peekdata
warning('off','imaq:peekdata:tooManyFramesRequested');

%%
warning('off', 'Images:initSize:adjustingMag');

%% Instancia um objeto videoinput
vid_obj = videoinput('macvideo', 1, 'YCbCr422_1280x720');

%% Configura o tipo de trigger para manual
triggerconfig(vid_obj, 'manual');

%% Inicia o objeto de vídeo de entrada
start(vid_obj);

%% Espera por peekdata para retornar um frame
while isempty(peekdata(vid_obj,1))
end

while 1
    
    %% Atualiza a imagem
    img = flipdim(ycbcr2rgb(peekdata(vid_obj,1)),2);
    
    %% Exibe a imagem
    imshow(img);
        
    imgF = imfilter(img, ones(9)/sum(sum(ones(9))));

    imgHSV = rgb2hsv(imgF);
    h = imgHSV(:,:,1);
    s = imgHSV(:,:,2);
    
    imgBW = logical(thresholding(h, .6)) & logical(thresholding(s, .7));
            
    [L Ne] = bwlabel(imgBW);
    props = regionprops(L);
    hold on
    for i=1:length(props)
        if (props(i).Area > 1000)
            rectangle('Position', props(i).BoundingBox, ...
                'EdgeColor', 'g', 'LineWidth', 3);
            plot(props(i).Centroid(1), props(i).Centroid(2),...
                'g*', 'LineWidth', 3);
        end
    end
        
    drawnow% flush video buffer
end

%% Stop video input object
stop(vid_obj);
%% Remove video input object from memory
delete(vid_obj)
if ~isvalid(vid_obj)
    clear vid_obj
end
%% Turn on the warning message for peekdata
warning('on','imaq:peekdata:tooManyFramesRequested');

path(p);


