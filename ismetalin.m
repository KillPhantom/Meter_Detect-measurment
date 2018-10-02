function [line,top,centerY]=ismetalin(ImageGray) 
[m,n]=size(ImageGray);
centerY=0;
top=0;
line=-1;
bw=im2bw(ImageGray,0.8*graythresh(ImageGray));
figure();
imshow(bw);
bw=bwareaopen(bw,round(n*m*0.0008));
bw=bw-bwareaopen(bw,round(n*m*0.06));
figure();
imshow(bw);
L = bwlabeln(bw);%标记块
S = regionprops(L,'BoundingBox');%统计
n=length(S);
box=zeros(n,4);
for i=1:n
    box(i,:)=S(i).BoundingBox;
end
bottom=box(:,2)+box(:,4);
distance=zeros(length(bottom),1);
for i=1:length(bottom)
    temp=0;
    for j=1:length(bottom)
        if(bottom(j)<=bottom(i)+3&&bottom(j)>=bottom(i)-3)
            temp=temp+1;
        end
    end
    distance(i)=temp;
end
distancenew=max(distance);
top=10000;
if distancenew<=2
    line=-1;
else
    for i=1:length(distance)
        if distance(i)==distancenew
            if top>box(i,2)
                top=box(i,2);
                line=box(i,2)+box(i,4);
                centerY=box(i,1)+box(i,3)/2;
            end
        end
    end
end
end
% m=find([S.Area]==max([S.Area]));%找最大块编号
% ImageGrayEdge=edge(ImageGray,'canny',0.2);
% figure(3);
% imshow(ImageGrayEdge);
% 
% Newimage=ImageGrayEdge;
% Newimage=bwmorph(Newimage,'bridge');
% L = bwlabeln(Newimage);%标记块
% S = regionprops(L, 'Area','BoundingBox');%统计
% m=find([S.Area]==max([S.Area]));%找最大块编号
% Newimage = ismember(L,m);%找到该区域
% Newimage=bwmorph(Newimage,'spur',10);
% 
% p=zeros(2,500);
% k=1;
% [m,n]=size(Newimage);
% for i=1:m
%     for j=1:n
%         if(Newimage(i,j)==1)
%            p(:,k)=[i;j];
%            k=k+1;
%         end
%     end
% end
% 
% pp=p(:,1:k-1);
% x=pp(1,:)';
% y=pp(2,:)';
% 
% % A=[x.*x,x.*y,y.*y,x,y];
% % b=-ones(length(x),1);
% % Solution=A\b;
% % a=Solution(1);
% % b=Solution(2);
% % c=Solution(3);
% % d=Solution(4);
% % e=Solution(5);
% % XC=(b*e-2*c*d)/(4*a*c-b*b);
% % YC=(b*d-2*a*e)/(4*a*c-b*b);
% % a=num2str(Solution);
% % name=strcat(a(1,:),'*y^2+',a(2,:),'*y*x+',a(3,:),'*x^2+',a(4,:),'*y+',a(5,:),'*x+','1');
% 
% A=[x.*x,y.*y,x,y];
% b=-ones(length(x),1);
% Solution=A\b;
% a=Solution(1);
% b=0;
% c=Solution(2);
% d=Solution(3);
% e=Solution(4);
% XC=(b*e-2*c*d)/(4*a*c-b*b);
% YC=(b*d-2*a*e)/(4*a*c-b*b);
% a=num2str(Solution);
% name=strcat(a(1,:),'*y^2+',a(2,:),'*x^2+',a(3,:),'*y+',a(4,:),'*x+','1');
% % name=strcat(a(1,:),'*y^2+',a(2,:),'*y*x+',a(3,:),'*x^2+',a(4,:),'*y+',a(5,:),'*x+','1');
% figure(1);
% hold on
% ezplot(name,[0,200],[0,200]);
% hold on;
% plot(y,x,'o');
% hold on;
% plot(YC,XC,'ro');
% 
% figure(4);
% imshow(Newimage);
% title('颜色信息二值化');
% 
% 
% 
% 
% 
% 
% % Imagebw=im2bw(ImageGray,0.4);
% % figure(4);
% % imshow(Imagebw);