%% Limpa as variáveis e fecha as janelas
clear; close all; clc
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
    im = flipdim(ycbcr2rgb(peekdata(vid_obj,1)),2);
    
    %% Exibe a imagem
    imshow(im);
    
    %     %% Convert and slice in HSV
    %     im2 = rgb2hsv(im);
    %     h = im2(:,:,1);
    %     s = im2(:,:,2);
    %     v = im2(:,:,3);
    %     %% Detect color (binarize)
    %     %im2 = im_bw(h, 0.2, 0.4) & im2bw(s, 0.25); % Verde
    %     im_blue = im_bw(h, 0.55, 0.75) & im_bw(s, 0.6, 1); % Azul
    %     %im2 = im_bw(h, 0.1
    %     im_red = im_bw(h, 0, 0.25) & im_bw(s, 0.6, 1); % Vermelho
    
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

%sudo killall VDCAssistant