clc 
clear all
close all

Image=imread('全孔剪切图/圆孔1.jpg');
figure(1),
imshow(Image)
[m,n,k]=size(Image);
ImageGray=rgb2gray(Image);
figure(2);
imshow(ImageGray);
ImageGrayEdge=edge(ImageGray,'canny',0.1);
figure(3);
imshow(ImageGrayEdge);
Newimage=ImageGrayEdge;
rangeimage=bwmorph(Newimage,'dilate',1);
figure(4);
imshow(rangeimage);
rangeimage=imfill(rangeimage,'holes');
figure(5);
imshow(rangeimage);
rangeimage=bwmorph(rangeimage,'erode',2);
L = bwlabeln(rangeimage);%标记块
S = regionprops(L, 'Area','BoundingBox');%统计
m=find([S.Area]==max([S.Area]));%找最大块编号
rangeimage = ismember(L,m);%找到该区域
box=S(m).BoundingBox;

figure(6);
imshow(rangeimage);
Newimage=bwareaopen(Newimage,20);
Newimage=Newimage&rangeimage;
figure(7);
imshow(Newimage);
YC=round(box(1)+box(3)/2);
bottom=round(box(2)+box(4)*80/330);
top=round(box(2)+box(4)-box(4)*80/330);
right=round(box(1)+box(3)-box(3)*120/330);
left=round(box(1)+box(3)*120/330);
figure(10)
cannyed=edge(ImageGray,'canny',0.05);
figure(11);
imshow(cannyed);
figure(30);
imshow(ImageGray(bottom:top,left:right));
cannyed=cannyed(bottom:top,left:right);
figure(12);
imshow(cannyed);
se=[1,1];
cannyed=imerode(cannyed,se);
figure(15);
imshow(cannyed);


L = bwlabeln(cannyed);%标记块
S = regionprops(L, 'Area','BoundingBox');%统计
m=size(S);

j=1;
for i=2:m
    flag=0;
    for k=1:j
        if(S(i).BoundingBox(2)==S(k).BoundingBox(2))
            S(k).Area=S(i).Area+S(k).Area;
            flag=1;
            break;
        end
    end
    if flag==0
        j=j+1;
    end
end

m=j;
for i=1:m
    for k=i+1:m
        if(S(k).Area>S(i).Area)
            temp=S(i);
            S(i)=S(k);
            S(k)=temp;
        end
    end
end
m=10;
if m>j
    j=m;
end
mindis=10000;
for i=1:m
    dis=0;
    for j=1:m
        dis=dis+norm(S(i).BoundingBox(2)-S(j).BoundingBox(2),2);
    end
    if(dis<mindis)
        mindis=dis;
        keep=i;
    end
end
box=S(keep).BoundingBox;
line=round(box(2)+box(4)/3);
line=line+bottom;
figure(13)
imshow(cannyed);
imshow(cannyed);
[m,n,k]=size(Image);
ifelse:
   cannyed=edge(ImageGray,'canny');
   figure;
   imshow(cannyed);
   top=round(line)+5;
   YC=round(centerY);
   if top<m
       while(cannyed(top,YC)==0)
          top=top+1;
          if(top>=m)
              top=line;
              break;
          end
       end
   else
        top=line;
   end
if(top<=m&&bottom>=0&&line<=top&&line>=bottom)
draw( Image,round(YC),round(top),round(bottom),round(line));
else
drawERRO(Image);
end








% Imagebw=im2bw(ImageGray,0.4);
% figure(4);
% imshow(Imagebw);