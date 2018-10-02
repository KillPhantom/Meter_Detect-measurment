clc 
clear all
close all

Image=imread('out8/output17_1.jpg');
figure(1),
imshow(Image)
[m,n,k]=size(Image);

if(m<2.5*n)
    ImageGray=rgb2gray(Image);
    figure(2);
    imshow(ImageGray);
    [line,bottom,centerY]=ismetalin(ImageGray);
    if line==-1
        [ImageGrayEdge,pa]=edge(ImageGray,'canny',0.1);
%         se=[1,1];
%         ImageGrayEdge=imerode(ImageGrayEdge,se);
%         ImageGrayEdge=bwareaopen(ImageGrayEdge,10);
        figure(3);
        imshow(ImageGrayEdge);
       
           Newimage=ImageGrayEdge;
           rangeimage=bwmorph(Newimage,'dilate',1);
           figure(4);
           imshow(rangeimage);
           rangeimage=imfill(rangeimage,'holes');
           figure(5);
           imshow(rangeimage);
           
           figure(3);
           imshow(ImageGrayEdge);
           rangeimage=bwmorph(rangeimage,'erode',2);
           L = bwlabeln(rangeimage);%标记块
           S = regionprops(L, 'Area','BoundingBox');%统计
           m=find([S.Area]==max([S.Area]));%找最大块编号
           rangeimage = ismember(L,m);%找到该区域
           box=S(m).BoundingBox;
           box
        figure(21);
        imshow(rangeimage);
       
    %     Newimage=bwmorph(Newimage,'bridge');

        Newimage=bwareaopen(Newimage,20);
        Newimage=Newimage&rangeimage;
        figure(12);
        imshow(Newimage);
%     Newimage=bwmorph(Newimage,'spur',5);
%         A=[x.*x,x.*y,y.*y,x,y];
%         b=-ones(length(x),1);
%         Solution=A\b;
%         a=Solution(1);
%         b=Solution(2);
%         c=Solution(3);
%         d=Solution(4);
%         e=Solution(5);
%         XC=(b*e-2*c*d)/(4*a*c-b*b);
%         YC=(b*d-2*a*e)/(4*a*c-b*b);
%         a=num2str(Solution);
%         name=strcat(a(1,:),'*y^2+',a(2,:),'*y*x+',a(3,:),'*x^2+',a(4,:),'*y+',a(5,:),'*x+','1');
%         p=zeros(2,500);
%         k=1;
%         [m,n]=size(Newimage);
%         for i=1:m
%             for j=1:n
%                 if(Newimage(i,j)==1)
%                    p(:,k)=[i;j];
%                    k=k+1;
%                 end
%             end
%         end
%         pp=p(:,1:k-1);
%         x=pp(1,:)';
%         y=pp(2,:)';
%         A=[x.*x,y.*y,x,y];
%         b=-ones(length(x),1);
%         Solution=A\b;
%         a=Solution(1);
%         b=0;
%         c=Solution(2);
%         d=Solution(3);
%         e=Solution(4);
% %         %二次迭代
% %         k=1;
% %         [m,n]=size(Newimage);
% %         for i=1:m
% %             for j=1:n
% %                 if(Newimage(i,j)==1&&eclipin(i,j,a,b,c,d,e)<0)
% %                    p(:,k)=[i;j];
% %                    k=k+1;
% %                 end
% %             end
% %         end
% %         pp=p(:,1:k-1);
% %         x=pp(1,:)';
% %         y=pp(2,:)';
% %         A=[x.*x,y.*y,x,y];
% %         b=-ones(length(x),1);
% %         Solution=A\b;
% %         a=Solution(1);
% %         b=0;
% %         c=Solution(2);
% %         d=Solution(3);
% %         e=Solution(4);
% %         %三次迭代
% %         k=1;
% %         [m,n]=size(Newimage);
% %         for i=1:m
% %             for j=1:n
% %                 if(Newimage(i,j)==1&&eclipin(i,j,a,b,c,d,e)<0)
% %                    p(:,k)=[i;j];
% %                    k=k+1;
% %                 end
% %             end
% %         end
% %         pp=p(:,1:k-1);
% %         x=pp(1,:)';
% %         y=pp(2,:)';
% %         A=[x.*x,y.*y,x,y];
% %         b=-ones(length(x),1);
% %         Solution=A\b;
% %         a=Solution(1);
% %         b=0;
% %         c=Solution(2);
% %         d=Solution(3);
% %         e=Solution(4);
% % %                 %四次迭代
% %         k=1;
% %         [m,n]=size(Newimage);
% %         for i=1:m
% %             for j=1:n
% %                 if(Newimage(i,j)==1&&eclipin(i,j,a,b,c,d,e)<0)
% %                    p(:,k)=[i;j];
% %                    k=k+1;
% %                 end
% %             end
% %         end
% %         pp=p(:,1:k-1);
% %         x=pp(1,:)';
% %         y=pp(2,:)';
% %         A=[x.*x,y.*y,x,y];
% %         b=-ones(length(x),1);
% %         Solution=A\b;
% %         a=Solution(1);
% %         b=0;
% %         c=Solution(2);
% %         d=Solution(3);
% %         e=Solution(4);
%         
%         XC=(b*e-2*c*d)/(4*a*c-b*b);
%         YC=(b*d-2*a*e)/(4*a*c-b*b);
%         YC=round(YC);
%         XC=round(XC);
%         a=num2str(Solution);
%         name=strcat(a(1,:),'*y^2+',a(2,:),'*x^2+',a(3,:),'*y+',a(4,:),'*x+','1');
%         % name=strcat(a(1,:),'*y^2+',a(2,:),'*y*x+',a(3,:),'*x^2+',a(4,:),'*y+',a(5,:),'*x+','1');
%         figure(1);
%         hold on
%         ezplot(name,[0,400],[0,400]);
%         hold on;
%         plot(YC,XC,'ro');
%         figure(4);
%         imshow(Newimage);
%         title('椭圆轮廓');
%        cannyedob=edge(ImageGray,'canny',0.3);
%        cannyedob=bwareaopen(cannyedob,20);
%        figure;
%        imshow(cannyedob);
%        top=XC;
%        bottom=XC;
       
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
        

        
%         for i=1:m
%             for j=1:n
%                 if(j<bottom||j>top||i<left||i>right)
%                     cannyed(i,j)   
%                     disp('here');
%                 end
%             end 
%         end
        figure(12);
        imshow(cannyed);
%         cannyed=bwareaopen(cannyed,20);
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
        
%         j=1;
%         for i=2:m
%             for k=1:j
%                 if(S(i).BoundingBox(2)==S(j).BoundingBox(2))
%                     S(j).Area=S(i).Area+S(j).Area;
%                     break;
%                 else
%                     j=j+1;
%                 end
%             end
%         end
%         for 
        
%         m=find([S.Area]==max([S.Area]));%找最大块编号
%         cannyed = ismember(L,m);%找到该区域
        box=S(keep).BoundingBox;
        line=round(box(2)+box(4)/3);
        line=line+bottom;
        figure(13)
        imshow(cannyed);
        imshow(cannyed);
        [m,n,k]=size(Image);
        
       
%         line1=round(top)-round(0.1*m);
%         line2=round(bottom)+round(0.1*m);
%         i=1;
%         mindis=1000;
%        while(mindis>0.02*m&&i<30)
%            line1=round(top)-round(0.1*m);
%            line2=round(bottom)+round(0.1*m);
%            while(cannyed(line1,YC)==0)
%                line1=line1-1;
%            end
%            while(cannyed(line2,YC)==0)
%                line2=line2+1;
%            end
%            if(mindis>=abs(line1-line2))
%                mindis=abs(line1-line2);
%                line1keep=line1;
%                line2keep=line2;
%                disp('here');
%            end
%            cannyed=edge(ImageGray,'canny',0.02+i*0.01);
%            cannyed=bwareaopen(cannyed,20);
%            imshow(cannyed);
%            pause(0.5);
%            i=i+1;
%            i
%        end
%        if i==30
%            line=round((line1keep+line2keep)/2);
%        else
%            line=round((line1+line2)/2);
%        end
       
%        line1=round(top)-round(0.05*m);
%        while(cannyed(line1,YC)==0)
%            line1=line1-1;
%        end
%        
%        line2=round(bottom)+round(0.05*m);
%        while(cannyed(line2,YC)==0)
%            line2=line2+1;
%        end
       
%        if(abs(line1-line2)>0.05*m)
%            i=0;
%            j=0;
%            bottomnew=bottom-round(0.05*m);
%            while(cannyedob(bottomnew,YC)==0)
%                 bottomnew=bottomnew-1;
%                 i=i+1;
%            end
%            topnew=top+round(0.05*m);
%            while(cannyedob(topnew,YC)==0)
%                topnew=topnew+1;
%                j=j+1;
%            end
%            if(i>j)
%                line=bottom;
%                bottom=bottomnew;
%            else
%                line=top;
%                top=topnew;
%            end
%        end
    else
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
    end
else
    [line,top,bottom,YC]=ischangtiao(Image);
end
if(top<=m&&bottom>=0&&line<=top&&line>=bottom)
draw( Image,round(YC),round(top),round(bottom),round(line));
else
drawERRO(Image);
end








% Imagebw=im2bw(ImageGray,0.4);
% figure(4);
% imshow(Imagebw);