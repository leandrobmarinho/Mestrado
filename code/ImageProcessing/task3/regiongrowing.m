function imgOut=regiongrowing(imgIn,x,y,threshold)
% Executa o crescimento de regiao em uma imagem de um dado uma semente (x,y)
%
% imgSeg = regiongrowing(img,x,y,t) 
% 
% img : imagem de entrada
% imgSeg : imagem de saida logica da regiao
% x,y : a posicao da semente
% t : distancia de intensidade maxima
%


imgOut = zeros(size(imgIn)); % Imagem de saida 
Isizes = size(imgIn); % Dimensoes da imagem de entrada

meanReg = imgIn(x,y); % A media da regiao segmentada
sizeReg = 1; % Numero de pixels na regiao

% Memoria livre para armanezar os vizinhos da regiao segmentada
negFree = 20000; negPos=0;
negList = zeros(negFree,3); 

% Distancia da regiao do pixel mais recente para a regiao media
pixDist=0; 

% Locais dos Neighbor (footprint)
neigb=[-1 0; 1 0; 0 -1;0 1];

% Inicia o crescimento de regiao ate que a distancia entre a regia e um
% possivel novo pixel torne-se maior que um certo limiar
while(pixDist<threshold && sizeReg<numel(imgIn))

    % Adiciona novos pixels vizinhos
    for j=1:4,
        % Computa a coordenada da vizinhanca
        xn = x + neigb(j,1);
        yn = y + neigb(j,2);
        
        % Verifica se o vizinho est? dentro ou fora da imagem
        ins = (xn>=1) && (yn>=1) && (xn<=Isizes(1)) && (yn<=Isizes(2));
        
        % Adiciona o vizinho se estiver dentro e nao fa?a parte da area
        % segmentda
        if(ins && (imgOut(xn,yn)==0)) 
            negPos = negPos+1;
            negList(negPos,:) = [xn yn imgIn(xn,yn)];
            imgOut(xn,yn)=1;
        end
    end

    % Adiciona um novo bloco de memoria livre
    if(negPos+10>negFree),
        negFree=negFree+20000;
        negList((negPos+1):negFree,:)=0;
    end
    
    % Adiciona pixel com intensidade proxima a media da regiao, para a
    % regiao
    dist = abs(negList(1:negPos,3) - meanReg);
    [pixDist, index] = min(dist);
    imgOut(x,y)=2;
    sizeReg = sizeReg+1;
    
    % Computa a nova media da regiao
    meanReg= (meanReg*sizeReg + negList(index,3))/(sizeReg+1);
    
    % Salva as coordenadas x e y do pixel (para o processo de adicionar vizinhos)
    x = negList(index,1); y = negList(index,2);
    
    % Remove o pixel do vizinho 
    negList(index,:)= negList(negPos,:);
    negPos=negPos-1;
end

% Retorna a area segmentada como uma matriz logica
imgOut=imgOut>1;




