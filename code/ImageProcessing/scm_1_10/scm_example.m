%%%
%%% SCM examples
%%%

clc
clear
% path(path,'./scm_1_10/');

%% Feature Extraction
% Input sginal
f=imread('lena.tif');
if size(f,3)>1, f=rgb2gray(f); end
row=267; % Lena eyes = 267
col1=266; % Lena left eye = 266
col2=327; %124; % Lena right eye = 327

% SCM parameters
k=@(x,y)imfilter(x,fspecial(y),'replicate');


G(:,:,1)=f;
G(:,:,2)=f;
S=f(row,:);

f(row-1:row+1,:)=255;
f(:,col1-1:col1+1)=255;
f(:,col2-1:col2+1)=255;
G(:,:,3)=f;

figure(1);clf
subplot(2,2,1)
imshow(G)
% subplot(4,2,3)
% imshow(G(end/3:end*3/4,end/3:end*3/4,:))

tic
sigma=[0.1:0.1:1];
k=1;
clear p m pn pv
S=[S S(1:3)];
Sa=S;
for s=sigma
    F=imfilter(S,fspecial('Gaussian',[3 3],s),'replicate');
    for h=1:numel(S)-3
        [m,p]=scm(S(h:h+2),F(h:h+2),'NumL',16);
        pn=fieldnames(p);
        pv(:,h)=struct2array(p);
    end
    Sa=F;
    
    subplot(2,2,3)
    hold on
    plot(double(F)+k*100,'LineW',1.5)
    set(gca,'FontSize',18)
    ylabel('scale')
    title('Scaling by Gaussian smoothing with \sigma');
    set(gca,'YTickLabel',[])
    axis square tight, box on
    ax=axis;
    plot(repmat(col1,ax(4)-ax(3)+1,1),ax(3):ax(4),'k--')
    plot(repmat(col2,ax(4)-ax(3)+1,1),ax(3):ax(4),'k--')
    
    a=[1:8];
    SP=[4 5 6 10 11 12 16 17 18];
    for h=1:length(a)
        subplot(3,6,SP(h))
        hold on
        plot(pv(a(h),:)+k*2,'LineW',1.5)
        set(gca,'FontSize',18)
        set(gca,'YTickLabel',[])
        title(pn(a(h)))
        axis tight, box on
        ax=uint8(axis);
        plot(repmat(col1,ax(4)-ax(3)+1,1),ax(3):ax(4),'k--')
        plot(repmat(col2,ax(4)-ax(3)+1,1),ax(3):ax(4),'k--')

    end
    
    drawnow
    leg{k}=sprintf('\\sigma=%.1f',s);
    k=k+1
end
subplot(2,2,3)
legend(leg,'Location','Best')
toc

