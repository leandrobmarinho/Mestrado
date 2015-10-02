function circles = houghcircles(imgIn, minR, maxR, thresh, delta)

% Verifica os argumentos de entrada
if nargin==3
  thresh = 0.33;   % Um ter?o do perimetro
  delta = 12;      % Cada elemento em (x y r) pode desviar aproximadamente 4 pixels
elseif nargin==4
  delta = 12;
end

% Cria uma matriz 3D de Hough (duas primeiras dimensoes especifica a
% coordenada do circulo e a terceira o radii). Para acomodar circulos que
% os centros estao fora da imagem, as duas primeiras dimensoes sao
% extendidas para 2*maxR
maxR2 = 2*maxR;
hough = zeros(size(imgIn,1)+maxR2, size(imgIn,2)+maxR2, maxR-minR+1);

% Para pixel da borda (ex ey), as localizacoes dos seus correspondentes,
% possiveis centros estao dentro da regiao [bx-maxR:bx+maxR,
% by-maxR:by+maxR]. A grade [0:maxR2, 0:maxR2] ? criada primeiramente, e
% ent?o as distancias entre o centro e todos os pontos do grid s?o
% computadas para formar um mapa de raio
[X Y] = meshgrid(0:maxR2, 0:maxR2);
Rmap = round(sqrt((X-maxR).^2 + (Y-maxR).^2));
Rmap(Rmap<minR | Rmap>maxR) = 0;


% Ajusta o limiar e/ou mais alto e baixo para balancear entre a qualidade 
% de perfomace e detecao. Para cada pixel da borda, incrementa o elemento
% correspondente no vetor Hough. (Bx By) s?o as coordenadas dos pixels da
% borda e (Cy Cx R) s?o os centros e raio do circulo correspondente.
[By, Bx] = find(imgIn);
[Cy, Cx, R] = find(Rmap);
for i = 1:length(Bx);
  Index = sub2ind(size(hough), Cy+By(i)-1, Cx+Bx(i)-1, R-minR+1);
  hough(Index) = hough(Index)+1;
end

% Captura os circulos candidatos. Devido a digitalizacao, o numero de
% pixels de borda detectaveis ? aproximadamente 90% do perimetro calculado.
twoPi = 0.9*2*pi;
circles = zeros(0,4);    % Formato: (x y r t)
for radius = minR:maxR   % La?o do raio minimo ao maximo
  slice = hough(:,:,radius-minR+1);  % Offset do minR
  twoPiR = twoPi*radius;
  slice(slice<twoPiR*thresh) = 0;  % Limpa o contador de pixel < 0.9*2*pi*R*thresh
  [y, x, count] = find(slice);
  circles = [circles; [x-maxR, y-maxR, radius*ones(length(x),1), count/twoPiR]];
end

% Deleta os circulos similares
circles = sortrows(circles,-4);  % Ordena descrescentemente de acordo com o raio
i = 1;
while i<size(circles,1)
  j = i+1;
  while j<=size(circles,1)
    if sum(abs(circles(i,1:3)-circles(j,1:3))) <= delta
      circles(j,:) = [];
    else
      j = j+1;
    end
  end
  i = i+1;
end

end