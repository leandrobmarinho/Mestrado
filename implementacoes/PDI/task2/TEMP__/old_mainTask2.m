
% http://stackoverflow.com/questions/26142288/resize-an-image-with-bilinear-interpolation-without-imresize
% http://stackoverflow.com/questions/25674691/resize-image-without-imresize-matlab

%% 
img = imread('cameraman.tif');
[rows,columns]=size(img);
c = img (1:2:rows, 1:2:columns, : );
figure, imshow(c)
figure, imshow(img)

img = imread('cameraman.tif');
[rows,columns]=size(img);
c(1:2:rows, 1:2:columns, : ) = img;
figure, imshow(c)
figure, imshow(img)


l=imread('cameraman.tif');
[rows,columns]=size(l);
i=1; j=1;
c=zeros(rows/2,columns/2);
for x=1:2:rows
    for y=1:2:columns
        c(i,j)=l(x,y);
        j=j+1;
    end
    i=i+1;
    j=1;
end
figure,imshow(c/255);
 colormap(gray);
 
 
 inputImage = imread('cameraman.tif');
 scale = [.5 .5];              %# The resolution scale factors: [rows columns]
 oldSize = size(inputImage);                   %# Get the size of your image
 newSize = max(floor(scale.*oldSize(1:2)),1);  %# Compute the new image size
 
 %# Compute an upsampled set of indices:
 
 rowIndex = min(round(((1:newSize(1))-0.5)./scale(1)+0.5),oldSize(1));
 colIndex = min(round(((1:newSize(2))-0.5)./scale(2)+0.5),oldSize(2));
 
 %# Index old image to get new image:
 
 outputImage = inputImage(rowIndex,colIndex,:);
 figure, imshow(inputImage)
 figure, imshow(outputImage)