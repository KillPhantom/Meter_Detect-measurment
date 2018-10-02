function [line,top,bottom,centerY]=ischangtiao(orImage)
%ISCHANGTIAO Summary of this function goes here
%   Detailed explanation goes here
Image=orImage;
figure(7);
imshow(Image);
[p,n,k]=size(Image);
ImageGray=zeros(p,n);
brandGray=zeros(p,n);
figure(101);
imshow(ImageGray);
maxred=0;
for i=1:p
    for j=1:n
        r=double(orImage(i,j,1));
        g=double(orImage(i,j,2));
        b=double(orImage(i,j,3));
        on=r-g;
        tw=g-b;
%         if(r<130&&g<140&&b<140&&abs(r-g)<10&&abs(r-b)<10&&abs(g-b)<20)
        if((abs(on)<7&&abs(tw)<20))
        %if(abs(r-g)<10&&abs(r-b)<10&&abs(g-b)<20)
                ImageGray(i,j)=255;
        end
        if(on>maxred)
            maxred=on;
        end
    end
end

% for i=1:p
%     for j=1:n
%         r=double(orImage(i,j,1));
%         g=double(orImage(i,j,2));
%         b=double(orImage(i,j,3));
%         on=r-g;
%         if(on>maxred*0.7&&b<r);
%             brandGray(i,j)=255 ;
%         end
%     end
% end


figure(111);
imshow(ImageGray);
cannyImage=edge(rgb2gray(Image),'canny',0.15);
figure(911);
imshow(cannyImage);
ImageGray=cannyImage|ImageGray;
figure(922);
imshow(ImageGray);
ImageGray=bwmorph(ImageGray,'dilate',3);
% ImageGray=rgb2gray(Image);
figure(31);
imshow(ImageGray);
% ImageGray=bwmorph(ImageGray,'dilate',1);
    % imshow(ImageGray);
% cannyImage=edge(ImageGray,'canny',0.1);
% top=5;
% bottom=p-5;
% cannyImage=bwareaopen(cannyImage,10);
% while(cannyImage(top,round(n/2))~=1)
%     top=top+1;
% end
% 
% while(cannyImage(bottom,round(n/2))~=1)
%     bottom=bottom-1;
% end
% top=top+round(p/20);
% bottom=bottom-round(p/20);

% figure;
% imshow(cannyImage);
%         se=[1,1];
%         ImageGrayEdge=imerode(ImageGrayEdge,se);
%         ImageGrayEdge=bwareaopen(ImageGrayEdge,10);
         Newimage=ImageGray;
         
%            rangeimage=bwmorph(Newimage,'dilate',3);
           rangeimage=imfill(Newimage,'holes');
           figure(3);
           imshow(rangeimage);
           rangeimage=bwmorph(rangeimage,'erode',10);
           L = bwlabeln(rangeimage);%标记块
           S = regionprops(L, 'Area','BoundingBox');%统计
           m=find([S.Area]==max([S.Area]));%找最大块编号
           rangeimage = ismember(L,m);%找到该区域
        figure(211);
        imshow(rangeimage);
        box=S(m).BoundingBox;
        centerY=round(box(1)+box(3)/2);
        bottom=round(box(2));
        top=round(box(2)+box(4)-1);
        ImageGray=rgb2gray(orImage);
        figure(21);
        imshow(ImageGray);
        size(ImageGray)
        ImageGray=ImageGray(ceil(bottom):floor(top),ceil(box(1)):floor(box(1)+box(3)-1));
        figure(29);
        imshow(uint8(ImageGray));
ImageGray=im2bw(ImageGray,1.1*graythresh(ImageGray));
ImageGray=bwmorph(ImageGray,'open');
ImageGray=bwareaopen(ImageGray,25);
figure(30)
imshow(ImageGray);

Newimage=ImageGray;
L = bwlabeln(Newimage);%标记块
S = regionprops(L, 'Area','BoundingBox');%统计
max1=0;
max2=0;
for i=1:length(S)
    if(S(i).BoundingBox(3)>n/2)
        if(S(i).Area>max1)
            max1=S(i).Area;
            max1place=i;
        else
            if(S(i).Area>max2&&S(i).Area<max1)
                max2=S(i).Area;
                max2place=i;
            end
        end
    end
end
% max1place
% max2place
top1=S(max1place).BoundingBox(2)+S(max1place).BoundingBox(4);
top2=S(max2place).BoundingBox(2)+S(max2place).BoundingBox(4);
if abs(top1-S(max2place).BoundingBox(2))<abs(top2-S(max1place).BoundingBox(2))
   line=(top1+S(max2place).BoundingBox(2))/2;
else
   line=(top2+S(max1place).BoundingBox(2))/2;
end
line=line+bottom;
end
    


