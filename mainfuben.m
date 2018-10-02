clc 
clear all
close all

Image=imread('out8/output4_1.jpg');
figure(1),
imshow(Image)
[m,n,k]=size(Image);

if(m<2.5*n)
    ImageGray=rgb2gray(Image);
    figure(2);
    imshow(ImageGray);
    [line,bottom,centerY]=ismetalin(ImageGray);
    if line==-1
        ImageGrayEdge=edge(ImageGray,'canny',0.3);
        figure(3);
        imshow(ImageGrayEdge);
        Newimage=ImageGrayEdge;
    %     Newimage=bwmorph(Newimage,'bridge');


    %     L = bwlabeln(Newimage);%标记块
    %     S = regionprops(L, 'Area','BoundingBox');%统计
    %     m=find([S.Area]==max([S.Area]));%找最大块编号
    %     Newimage = ismember(L,m);%找到该区域
         Newimage=bwareaopen(Newimage,20);
    %     Newimage=bwmorph(Newimage,'spur',5);
        % A=[x.*x,x.*y,y.*y,x,y];
        % b=-ones(length(x),1);
        % Solution=A\b;
        % a=Solution(1);
        % b=Solution(2);
        % c=Solution(3);
        % d=Solution(4);
        % e=Solution(5);
        % XC=(b*e-2*c*d)/(4*a*c-b*b);
        % YC=(b*d-2*a*e)/(4*a*c-b*b);
        % a=num2str(Solution);
        % name=strcat(a(1,:),'*y^2+',a(2,:),'*y*x+',a(3,:),'*x^2+',a(4,:),'*y+',a(5,:),'*x+','1');
        p=zeros(2,500);
        k=1;
        [m,n]=size(Newimage);
        for i=1:m
            for j=1:n
                if(Newimage(i,j)==1)
                   p(:,k)=[i;j];
                   k=k+1;
                end
            end
        end
        pp=p(:,1:k-1);
        x=pp(1,:)';
        y=pp(2,:)';
        A=[x.*x,y.*y,x,y];
        b=-ones(length(x),1);
        Solution=A\b;
        a=Solution(1);
        b=0;
        c=Solution(2);
        d=Solution(3);
        e=Solution(4);
        %二次迭代
%         k=1;
%         [m,n]=size(Newimage);
%         for i=1:m
%             for j=1:n
%                 if(Newimage(i,j)==1&&eclipin(i,j,a,b,c,d,e)<0)
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
%         %三次迭代
%         k=1;
%         [m,n]=size(Newimage);
%         for i=1:m
%             for j=1:n
%                 if(Newimage(i,j)==1&&eclipin(i,j,a,b,c,d,e)<0)
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
%                 %四次迭代
%         k=1;
%         [m,n]=size(Newimage);
%         for i=1:m
%             for j=1:n
%                 if(Newimage(i,j)==1&&eclipin(i,j,a,b,c,d,e)<0)
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
        
        XC=(b*e-2*c*d)/(4*a*c-b*b);
        YC=(b*d-2*a*e)/(4*a*c-b*b);
        YC=round(YC);
        XC=round(XC);
        a=num2str(Solution);
        name=strcat(a(1,:),'*y^2+',a(2,:),'*x^2+',a(3,:),'*y+',a(4,:),'*x+','1');
        % name=strcat(a(1,:),'*y^2+',a(2,:),'*y*x+',a(3,:),'*x^2+',a(4,:),'*y+',a(5,:),'*x+','1');
        figure(1);
        hold on
        ezplot(name,[0,400],[0,400]);
        hold on;
        plot(YC,XC,'ro');
        figure(4);
        imshow(Newimage);
        title('椭圆轮廓');
       cannyedob=edge(ImageGray,'canny',0.4);
       cannyedob=bwareaopen(cannyedob,20);
       figure;
       imshow(cannyedob);
       top=XC;
       bottom=XC;
       

       while(cannyedob(top,YC)==0)
           top=top+1;
       end
       while(cannyedob(bottom,YC)==0)
           bottom=bottom-1;
       end
       figure;
       cannyed=edge(ImageGray,'canny',0.1);
       cannyed=bwareaopen(cannyed,20);
       imshow(cannyed);
       
       line=round(top)-round(0.05*m);
       while(cannyed(line,YC)==0)
           line=line-1;
       end
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