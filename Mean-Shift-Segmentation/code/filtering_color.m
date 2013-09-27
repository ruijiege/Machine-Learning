function [Ycon,Ycon_num,Ycon_center]=filtering_color(ButterflyPath,hs,hr)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize
imgdata=imread(ButterflyPath);
orgimg=im2double(imgdata)*255;

[row col dimention]=size(orgimg);
fprintf('This is a color image,now covert to luv formate\r\n');
orgluv=rgb2luv(orgimg);

Ycon=zeros(row,col,3);
Ycon_num=1;
Ycon_center(Ycon_num,1)=1;
Ycon_center(Ycon_num,2)=1;
itrationt=0;
flage=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:row    
    i
    for j=1:col
        
        flag_conv=1;
        now_center_x=i;
        now_center_y=j;
        for dimn=1:3
            now_center_value(dimn)=orgluv(i,j,dimn);
        end
        while(flag_conv)
            itrationt=itrationt+1;
            if itrationt==100
                flage=1;
            end
            sum_g=0;
            sum_point_x=0;
            sum_point_y=0;
            
          
            sum_point_value(1)=0;
            sum_point_value(2)=0;
            sum_point_value(3)=0;
          
            
            for m=max(1,(now_center_x-hs)):min(row,(now_center_x+hs))
                for n=max(1,(now_center_y-hs)):min(col,(now_center_y+hs))
                    
                    x1=((orgluv(m,n,1)-now_center_value(1))^2);
                    x1=x1+((orgluv(m,n,2)-now_center_value(2))^2);
                    x1=(x1+((orgluv(m,n,3)-now_center_value(3))^2))/(hr^2);

                    x2=((m-now_center_x)^2+(n-now_center_y)^2)/(hs^2);
                    g=exp(-(x1+x2)/2); %k(x)    
                    
                    sum_g=sum_g+g;
                    sum_point_x=sum_point_x+m*g;
                    sum_point_y=sum_point_y+n*g;                   
                    sum_point_value(1)=sum_point_value(1)+orgluv(m,n,1)*g;
                    sum_point_value(2)=sum_point_value(2)+orgluv(m,n,2)*g;
                    sum_point_value(3)=sum_point_value(3)+orgluv(m,n,3)*g;
                end
            end
            pre_center_x=now_center_x;
            pre_center_y=now_center_y;
            
            now_center_x=round(sum_point_x/sum_g);
            now_center_y=round(sum_point_y/sum_g);
            now_center_value(:)=sum_point_value(:)/sum_g;
            
            if (((pre_center_x-now_center_x)<2)&&((pre_center_y-now_center_y)<2)==1)
                Ycon(i,j,:)=now_center_value(:);
                Ycon_num=Ycon_num+1;
                Ycon_center(Ycon_num,1)=now_center_x;
                Ycon_center(Ycon_num,2)=now_center_y;

                flag_conv=0;
            end
            if flage
                Ycon(i,j,:)=now_center_value(:);
                Ycon_num=Ycon_num+1;
                Ycon_center(Ycon_num,1)=now_center_x;
                Ycon_center(Ycon_num,2)=now_center_y;

                flag_conv=0;
                itrationt=0;
                flage=0;
            end
        end
    end
end




