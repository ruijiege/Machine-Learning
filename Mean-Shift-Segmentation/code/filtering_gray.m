function [Ycon,Ycon_num,Ycon_center]=filtering_gray(HousePath,hs,hr)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize
imgdata=imread(HousePath);
orgimg=im2double(imgdata)*255;
[row col]=size(orgimg);
Ycon=zeros(row,col);
Ycon_num=1;
Ycon_center(Ycon_num,1)=1;
Ycon_center(Ycon_num,2)=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:row    
    i
    for j=1:col
        
        flag_conv=1;
        now_center_x=i;
        now_center_y=j;
        
        now_center_value=orgimg(i,j);
        while(flag_conv)
            sum_g=0;
            sum_point_x=0;
            sum_point_y=0;
            sum_point_value=0;
            for m=max(1,(now_center_x-hs)):min(row,(now_center_x+hs))
                for n=max(1,(now_center_y-hs)):min(col,(now_center_y+hs))
                    
                    x1=((orgimg(m,n)-now_center_value)^2)/(hr^2);
                    x2=((m-now_center_x)^2+(n-now_center_y)^2)/(hs^2);
                    g=exp(-(x1+x2)/2); %k(x)    
                    
                    sum_g=sum_g+g;
                    sum_point_x=sum_point_x+m*g;
                    sum_point_y=sum_point_y+n*g;                   
                    sum_point_value=sum_point_value+orgimg(m,n)*g;
                    
                end
            end
            pre_center_x=now_center_x;
            pre_center_y=now_center_y;
            
            now_center_x=round(sum_point_x/sum_g);
            now_center_y=round(sum_point_y/sum_g);
            now_center_value=sum_point_value/sum_g;
            
            if (((pre_center_x-now_center_x)<2)&&((pre_center_y-now_center_y)<2)==1)
                Ycon(i,j)=now_center_value;
                Ycon_num=Ycon_num+1;
                Ycon_center(Ycon_num,1)=now_center_x;
                Ycon_center(Ycon_num,2)=now_center_y;

                flag_conv=0;
            end
        end
    end
end

Ycon_kmean=zeros(row,col);
zero_r=zeros(hs,512+2*hs);
zero_c=zeros(512,hs);
Ycon1=[zero_c Ycon zero_c];
Ycon2=[zero_r;Ycon1;zero_r];
%size_aa=size(Ycon2);

 

    for i=(hs+1):(512+hs)
        for j=(hs+1):(512+hs)
            num=0;
            sum_val=0;
            for m=(i-hs):(i+hs)
                for n=(j-hs):(j+hs)
                    diff=abs(Ycon2(i,j)-Ycon2(m,n));
                    if diff<(hr)
                        num=num+1;
                        sum_val=sum_val+Ycon2(m,n);
                    end
                end
            end
            Ycon_kmean(i-hs,j-hs)=sum_val/num;
        end
    end

Ycon=Ycon_kmean;

