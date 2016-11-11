function [M,p] = scm(varargin)
%SCM - Structural cooccurrence Matrix - v1.10 by Geraldo Ramalho aug/2016
%
%   Implementation of the algorithm from the original paper:
%       Ramalho et al. Rotation-invariant Feature Extraction using a Structural Co-occurrence Matrix.
%       Measurement, v.??, n.??, p.???-???, 2016.
%       doi:10.1016/j.measurement.2016.08.012
%       (scm v1.00 available in http://lapisco.ifce.edu.br/?page_id=191)
%
%   M = SCM(f,g) analyzes pairs of pixels between a partitioned signal f
%   and a partitioned signal g. Both signals can be two-dimensional (images).
%   Input signals are partitioned by a function 'Q' to 8 levels, by
%   default using a quantization function.
%
%   g can be filtered by a high-pass or low-pass filter "k" to highlight
%   the saliences, i.e., the structural differences between f and g.
%   "k" is a filter function that is not implemented in this code version.
%   Thus, g must be filtered before calling SCM, if required by the application.
%
%   f/g can be numeric or logical.  f/g can be 1D or 2D.
%   M is an 'NumParts'-by-'NumParts'-by-P double array where P is the number of
%   offsets in OFFSET.
%
%   M = SCM(f,g,PARAM1,VALUE1,PARAM2,VALUE2,...) returns one
%   matrix depending on the values of the
%   optional parameter/value pairs.
%
%   Parameters:
%   'Offset'         A p-by-2 array of offsets specifying the distance "d"
%                    between the pixel-of-interest in image f and its
%                    neighbor at image g.
%                    Default: [0 0]
%
%   'NumParts'       An integer specifying the number of partitions (N) to use
%                    when scaling the grayscale values in I. For example,
%                    if 'NumParts' is 8, scmmatrix partitions the values in
%                    I and g so they are integers between 1 and 8.  The number of
%                    partitions determines the size of the matrix SCM.
%                    'NumParts' must be an integer. 'NumParts' must be 2
%                    if I is logical.
%                    Default: 8 for numeric; 2 for logical
%
%   'GrayLimits'     A two-element vector, [LOW HIGH], that specifies how
%                    the grayscale values in I are linearly scaled into
%                    gray levels. Grayscale values less than or equal to
%                    LOW are scaled to 1. Grayscale values greater than or
%                    equal to HIGH are scaled to HIGH.  If 'GrayLimits' is
%                    set to [], scmmatrix uses the minimum and maximum
%                    grayscale values in I as limits,
%                    [min(I(:)) max(I(:))].
%                    Default: [LOW HIGH] is [0 1] if I is double and
%                    [-32768 32767] if I is int16.
%
%   'Symmetric'      A Boolean that creates a symmetric SCM.
%                    'Symmetric' must be set to false in order to calculate
%                    all SCM attributes.
%                    Default: false
%
%   'PartName'       Specifies a call-out partition function name: TV (total variation),AV (average)
%                    to merge pixels into macro structures (superpixels) before perform quantization.
%                    Default: 'Q' = only quantization.
%
%   'PartitionFunction'   Specifies a user partition function.
%                    Default: @(signal,numparts)default_partition_function.
%
%   'PropValue'      Specifies the value of the default propertyfunction function (P) that relates abs(Q(I)-Q(k(g)))<propvalue.
%                    Parameter value 'propvalue' is a threshold for the propertyfunction function.
%                    Default: N
%
%   'PropertyFunction' Specifies a user property function (P).
%                    Default: @(signal1,signal2,propvalue)default_property_function
%
%   'TransName'      Specifies a transform function name: LowPass, HighPass or None
%                    to change the structural information on g.
%                    Default: 'None'
%
%   'TransformFunction' Specifies a user transform function (k).
%                    Default: @(signal,transfame)default_transform_function.
%
%
%   Notes
%   -----
%   SCM is inspired by the method of relative frequency to approximate probabilities
%   based on the concept of the algorithm of 2D-histograms
%   (Sahoo,2004; Abutaleb,1989) by changing the average image with a second
%   different image. SCM generalizes SIM (Ramalho et al, 2014) and adds new attributes.
%
%   SCM ignores pixels pairs if either of their values is NaN. It
%   replaces the values with 'NumParts' if value>'NumParts'.
%
%   References
%   ----------
%   P.K. Sahoo and G. Arora,  A thresholding method based on two-dimensional
%   Renyi's entropy. In Proceedings of Pattern Recognition. 2004, 1149-1161.
%
%   Abutaleb, A. S.(1989). Automatic thresholding of gray-level pictures
%   using two-dimensional entropy. Journal of Computer Vision, Graphic and
%   Image Process, Vol. 47, (1989) 22?32
%
%   Ramalho,G.L.B., Reboucas Filho,P.P., de Medeiros,F.N.S., Cortez, P. C. Lung disease
%   detection using feature extraction and extreme learning machine,
%   Brazilian Journal of Biomedical Engineering 30 (2014) pages 363-376.
%
%   Example 1
%   ---------
%   Calculate SCM and return the
%   scaled version of the signal, SI, used by SCM to generate the
%   matrix M.
%
%        f = [1 1 5 6 8 8;2 3 5 7 0 2; 0 2 3 5 6 7];
%        g = [1 1 5 6 8 8;2 3 5 7 0 2; 0 2 3 5 6 7];
%       [M] = SCM(f,g,'NumParts',9,'G',[])
%
%   Example 2
%   ---------
%   Calculate SCM for a grayscale image
%   using four different offsets.
%
%       f = imread('cell.tif');
%       g = imread('circuit.tif');
%       offsets = [0 1;-1 1;-1 0;-1 -1];
%       [M,p] = scm(f,g,'NumParts',8,'G',[],'PropValue',9,'TransfName','average','TransformFunction',@(x,y)imfilter(x,fspecial(y)))
%
%   See also SCMPROPS.
%

warning off

[f,g,offset,NL,GL,symm,propertyfunction,propvalue,partname,partitionfunction,transfname,transformfunction] = ParseInputs(varargin{:});

kg=transformfunction(g,transfname);

Sf=partitionfunction(f,NL,GL,partname);
Sg=partitionfunction(kg,NL,GL,partname);

Sf(Sf > NL) = NL;
Sf(Sf < 1) = 1;
Sg(Sg > NL) = NL;
Sg(Sg < 1) = 1;

P=propertyfunction(Sf,Sg,propvalue);

offset_num = size(offset,1); % d

if NL ~= 0
    % row and column subscripts for every pixel and its neighbor
    s = size(f);
    [r,c] = meshgrid(1:s(1),1:s(2));
    r = r(:);
    c = c(:);
    
    % Compute M
    M = zeros(NL,NL,offset_num);
    for k = 1 : offset_num
        M(:,:,k) = computeSCM(r,c,offset(k,:),Sf,Sg,NL,P);%,propertyfunction,propvalue);
        
        if symm
            % Reflect SCM across the diagonal to make it symmetric
            SCMTranspose = M(:,:,k).';
            M(:,:,k) = M(:,:,k) + SCMTranspose;
        end
    end
    
else
    M = zeros(0,0,offset_num);
end

p=scmprops(M);

end

%-----------------------------------------------------------------------------
function m = computeSCM(r,c,offset,si,sit,nl,P)
% computes SCM given one Offset
r2 = r + offset(1);
c2 = c + offset(2);
[nRow nCol] = size(si);

% locations where subscripts outside the image boundary
pos_out = find(c2 < 1 | c2 > nCol | r2 < 1 | r2 > nRow);

v1 = shiftdim(si,1);
v1 = v1(:);
v1(pos_out) = [];
r2(pos_out) = [];
c2(pos_out) = [];
Index = r2 + (c2 - 1)*nRow;
v2 = sit(Index);
v2 = v2(:);

% remove pixels with value is NaN.
idx_nans = isnan(v1) | isnan(v2);
Ind = [v1 v2];
Ind(idx_nans,:) = [];

if isempty(Ind)
    m = zeros(nl);
else
    % occurrences of pixel pairs having v1 and v2.
    m = accumarray(Ind, 1, [nl nl]);
end

end

%-----------------------------------------------------------------------------
function [f,g,offset,nl,gl,sym,propertyfunction,propvalue,partname,partitionfunction,transfname,transformfunction] = ParseInputs(varargin)

narginchk(1,10);

% input signals
f = varargin{1};
g = varargin{2};

% Defaults
offset = [0 0];
if islogical(f)
    nl = 2;
else
    nl = 8;
end
gl = getrangefromclass(f);
sym = false;
propertyfunction=@default_property_function;
propvalue=nl; % default value
partitionfunction=@default_partition_function;
partname='Q'; % default quantization
transformfunction=@default_transform_function;
transfname='none'; % default transform

if nargin ~= 1
    PARAMS = {'Offset','NumParts','NumLevels','GrayLimits','Symmetric','PartName','PartitionFunction','PropValue','PropertyFunction','TransfName','TransformFunction'};
    
    for k = 3:2:nargin
        param = lower(varargin{k});
        inputStr = validatestring(param, PARAMS, mfilename, 'PARAM', k);
        idx = k + 1;
        
        if idx > nargin
            display('scm: missing value for ', inputStr);
            break
        end
        
        switch (inputStr)
            
            case 'Offset'
                
                offset = varargin{idx};
                if size(offset,2) ~= 2
                    display('scm: invalid Offset');
                    break
                end
                offset = double(offset);
                
            case {'NumParts','NumLevels'}
                nl = varargin{idx};
                if numel(nl) > 1
                    display('scm: invalid NumParts');
                elseif islogical(f) && nl ~= 2
                    display('scm: invalid NumParts');
                end
                nl = double(nl);
                
                
            case 'GrayLimits'
                gl = varargin{idx};
                if isempty(gl)
                    gl = [min(f(:)) max(f(:))];
                end
                if numel(gl) ~= 2
                    display('scm: invalid GrayLimits');
                    break
                end
                gl = double(gl);
                
            case 'Symmetric'
                sym = varargin{idx};
                
            case 'PartName'
                partname=(varargin{idx});
            case 'PartitionFunction'
                partitionfunction=varargin{idx};
            case 'PropValue'
                propvalue = varargin{idx};
                propvalue = abs(double(propvalue));
            case 'PropertyFunction'
                propertyfunction=varargin{idx};
            case 'TransfName'
                transfname=(varargin{idx});
            case 'TransformFunction'
                transformfunction=varargin{idx};
                
        end
    end
    
end
end

function Do = computeTotalVariation(Do,dt,N)
%função para cálculo do método Total Variation - LABVIS/UFC - 2008
%dt = passo de tempo de simulação
%Do = imagem original ou resultado de itera??es anteriores
Do = double(Do);
c = 0;
while (c<N)%
    U= padarray(Do,[2 2],'replicate','both');
    [A,B] = size(U);
    Dxp = U(3:A,2:B-1) - U(2:A-1,2:B-1);                        %A matriz menos sua vers?o deslocada nas linhas
    Dyp = U(2:A-1,3:B) - U(2:A-1,2:B-1);                        %A matriz menos sua vers?o deslocada nas colunas
    Dn = (Dxp.^2 + Dyp.^2).^0.5;                                %M?dulo das derivadas a direita
    D1 = Dxp./((abs(Dn)<=0.001).*1e10 + (abs(Dn)>0.001).*Dn);   %Dxp/Dn, substituindo valores de Dn muito pequenos
    D2 = Dyp./((abs(Dn)<=0.001).*1e10 + (abs(Dn)>0.001).*Dn);   %por valores muito grandes, para evitar erro
    [A,B] = size(D1);
    [Dxn,O]=gradient(D1);
    [O,Dyn]=gradient(D2);
    Dxn = D1(2:A-1,2:B-1) - D1(1:A-2,2:B-1);                    %Derivada de segunda ordem
    Dyn = D2(2:A-1,2:B-1) - D2(2:A-1,1:B-2);                    %Derivada de segunda ordem
    Dt = dt*(Dxn + Dyn);
    D = Do + Dt;
    c = c+1;
    Et(c)= mean2(Dt.^2);%entropy((gray2ind(mat2gray(D),256)));
    Do = D;
    
end
end


function transf=default_transform_function(s,varargin)
    transf=s;
    funcname=lower(varargin{1});%????

    if strcmp(funcname,'none'), % lowpass
    elseif strcmp(funcname,'lowpass'), % lowpass - 3x3 average filter
        transf=imfilter(s,fspecial('average',3))
    elseif strcmp(funcname,'highpass'), % lowpass - 3x3 average filter
        transf=imfilter(s,fspecial('laplacian'))
        slope = (NL-1) / (max(transf)-min(transf));
        intercept = 1 - (slope*(min(transf)));
        transf = round(imlincomb(slope,transf,intercept,'double'));
    end
end


function part=default_partition_function(s,NL,varargin)
part=s;
GL=varargin{1};%?????
partname=lower(varargin{2});%????
% partitioning between 1 and NL.
if GL(2) == GL(1)
    part = ones(size(f));
else % PARTITION
    % 27/11/2015
    if strcmp(partname,'q'), % quantization
        slope = (NL-1) / (GL(2) - GL(1));
        intercept = 1 - (slope*(GL(1)));
        part = round(imlincomb(slope,s,intercept,'double'));
    elseif strcmp(partname,'tv'), % total variation
        dt =0.002*double(max(f(:))-min(f(:)));
        part=round(computeTotalVariation((s),dt,NL));
        % pós-quantization -  28/11/2015
        slope = (NL-1) / (GL(2) - GL(1));
        intercept = 1 - (slope*(GL(1)));
        part = round(imlincomb(slope,part,intercept,'double'));
    elseif strcmp(partname,'km') % k-means
        nrows = size(f,1);
        ncols = size(f,2);
        ab = reshape(double(s),nrows*ncols,1);
        [cluster_idx, cluster_center] =kmeans(ab,NL);%,'distance','sqEuclidean', 'Replicates',3);
        part = reshape(cluster_idx,nrows,ncols);
        clear ab abt
    elseif strcmp(partname,'av'), % average
        part=imfilter(s,fspecial('average',[3 3]));
        % pós-quantization - 28/11/2015
        slope = (NL-1) / (GL(2) - GL(1));
        intercept = 1 - (slope*(GL(1)));
        part = round(imlincomb(slope,part,intercept,'double'));
    end
end
end

% ,propertyfunction,propvalue
function prop=default_property_function(s1,s2,varargin)
propvalue=varargin{1};%?????
prop=abs(s1-s2)<propvalue;
% if strcmp(lower(propname),'similarity') %  similaridade propertyfunction
%     [a b]=find(abs(diff(Ind'))<=propvalue);
%     Ind=Ind(b,:);
% elseif strcmp(lower(propname),'divergence') % divergência propertyfunction
%     [a b]=find(abs(diff(Ind'))>=propvalue);
%     Ind=Ind(b,:);
% end
end
