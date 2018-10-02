

Image=imread('out8/output4_1.jpg');
figure(1),

[p,n,k]=size(Image);

ImageGray=rgb2gray(Image);
imshow(ImageGray);
cannyImage=edge(ImageGray,'canny',0.2);
top=5;
bottom=p-5;
cannyImage=bwareaopen(cannyImage,20);
while(cannyImage(top,round(n/2))~=1)
    top=top+1;
end
while(cannyImage(bottom,round(n/2))~=1)
    bottom=bottom-1;
end
top=top+round(p/20);
bottom=bottom-round(p/20);

figure;
imshow(cannyImage);
ImageGray=im2bw(ImageGray,1.1*graythresh(ImageGray));
figure;
imshow(ImageGray);

ImageGray=bwareaopen(ImageGray,100);
Newimage=ImageGray;
L = bwlabeln(Newimage);%��ǿ�
S = regionprops(L, 'Area','BoundingBox');%ͳ��
m=find([S.Area]==max([S.Area]));%��������
line=S(m).BoundingBox(2)+S(m).BoundingBox(4)+round(p/60);