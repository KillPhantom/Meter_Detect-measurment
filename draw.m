function  draw( Image,centerx,top,bottom,line )
%DRAW Summary of this function goes here
%   Detailed explanation goes here
textplace=zeros(3,2);
centery=top;
[m,n,k]=size(Image);
for i=1:20
    if(centerx+i<=n&&centerx-i>1)
        Image(centery,centerx+i,1)=255;
        Image(centery,centerx+i,2)=0;
        Image(centery,centerx+i,3)=0;
        Image(centery,centerx-i,1)=255;
        Image(centery,centerx-i,2)=0;
        Image(centery,centerx-i,3)=0;
    end
end
Image(centery,centerx,1)=255;
Image(centery,centerx,2)=0;
Image(centery,centerx,3)=0;
textplace(1,:)=[centery,centerx];

centery=line;
for i=1:20
    if(centerx+i<=n&&centerx-i>1)
        Image(centery,centerx+i,1)=255;
        Image(centery,centerx+i,2)=0;
        Image(centery,centerx+i,3)=0;
        Image(centery,centerx-i,1)=255;
        Image(centery,centerx-i,2)=0;
        Image(centery,centerx-i,3)=0;
    end
end
Image(centery,centerx,1)=255;
Image(centery,centerx,2)=0;
Image(centery,centerx,3)=0;
textplace(2,:)=[centery,centerx];

centery=bottom;
for i=1:20
    if(centerx+i<=n&&centerx-i>1)
        Image(centery,centerx+i,1)=255;
        Image(centery,centerx+i,2)=0;
        Image(centery,centerx+i,3)=0;
        Image(centery,centerx-i,1)=255;
        Image(centery,centerx-i,2)=0;
        Image(centery,centerx-i,3)=0;
    end
end
Image(centery,centerx,1)=255;
Image(centery,centerx,2)=0;
Image(centery,centerx,3)=0;
textplace(3,:)=[centery,centerx];

percentage=(top-line)/(top-bottom);
percentage=round(percentage*100);

figure;
imshow(Image);
name=strcat(' \leftarrow',num2str(percentage),'%');
text(textplace(1,2)+20,textplace(1,1)-4,' \leftarrow0%','FontSize',10);
text(textplace(3,2)+20,textplace(2,1)-4,name,'FontSize',18,'color',[1,0,0]);
text(textplace(2,2)+20,textplace(3,1)-4,' \leftarrow100%','FontSize',10);

end
