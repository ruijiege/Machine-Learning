function [R_mark,R_num,val,Ycon]=cluster_color(Ycon,ButterflyPath,hs,hr)



[row col channel] =size(Ycon);

%size_aa=size(Ycon2);

R_mark(row,col)=0;
accessed(row,col)=0;
for i=1:row
    for j=1:col      
       R_mark(i,j)=0;
       accessed(i,j)=0;
    end
end
 

accessed(1,1)=1;
R_mark(1,1) =1;                               


entries    =1;                                  
flag_queue=1;
R_num=1;                             
P_shu(R_num)=1;                 

Qxy(1,1)  =1; 
Qxy(1,2)  =1; 

showi=1;
while(entries>0)
    showi
    showi=showi+1;
        M_shu=0;
        unvisited_num=0;        
        lable=zeros(4);
        if flag_queue
            x=Qxy(1,1);
            y=Qxy(1,2);
        end
        init1=R_mark(x,y);
        
        if ~init1
            if flag_queue
                R_num=R_num+1;
                R_mark(x,y)=R_num;
                P_shu(R_num)=1;
            end   
        end
        



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
                
        case1=(x-1>0)&&(y>0)&&(x-1<=row)&&(y<=col);
        case2=(x>0)&&(y-1>0)&&(x<=row)&&(y-1<=col);
        case3=(x+1>0)&&(y>0)&&(x+1<=row)&&(y<=col);
        case4=(x>0)&&(y+1>0)&&(x<=row)&&(y+1<=col);
        if case1
            if R_mark(x-1,y)==0

                diff_val=(Ycon(x-1,y,1)-Ycon(x,y,1))^2; 
                diff_val=diff_val+(Ycon(x-1,y,2)-Ycon(x,y,2))^2; 
                diff_val=diff_val+(Ycon(x-1,y,3)-Ycon(x,y,3))^2; 
                    if diff_val<=hr
                        R_mark(x-1,y)=R_mark(x,y);
                        P_shu(R_num)=P_shu(R_num)+1;
                    end
                if ~accessed(x-1,y)                                                                 
                    accessed(x-1,y)=1;
                    unvisited_num=unvisited_num+1;  
                    lable(1)=2;
                    if diff_val<=hr  
                        M_shu=M_shu+1;
                        lable(1)=1;
                    end                                             
                end

            end
        end
        

        if case2
            if R_mark(x,y-1)==0

                diff_val=(Ycon(x,y-1,1)-Ycon(x,y,1))^2; 
                diff_val=diff_val+(Ycon(x,y-1,2)-Ycon(x,y,2))^2; 
                diff_val=diff_val+(Ycon(x,y-1,3)-Ycon(x,y,3))^2;                     
                    if diff_val<=hr
                        R_mark(x,y-1)=R_mark(x,y);
                        P_shu(R_num)=P_shu(R_num)+1;
                    end
                if ~accessed(x,y-1)                                                                 
                    accessed(x,y-1)=1;
                    unvisited_num=unvisited_num+1; 
                    lable(2)=2;
                    if diff_val<=hr   
                        M_shu=M_shu+1;
                        lable(2)=1;
                    end                                             
                end

            end
        end
        
        
        if case3
            if R_mark(x+1,y)==0

                diff_val=(Ycon(x+1,y,1)-Ycon(x,y,1))^2; 
                diff_val=diff_val+(Ycon(x+1,y,2)-Ycon(x,y,2))^2; 
                diff_val=diff_val+(Ycon(x+1,y,3)-Ycon(x,y,3))^2;                     
                    if diff_val<=hr
                        R_mark(x+1,y)=R_mark(x,y);
                        P_shu(R_num)=P_shu(R_num)+1;
                    end
                if ~accessed(x+1,y)                                                                 
                    accessed(x+1,y)=1;
                    unvisited_num=unvisited_num+1;  
                    lable(3)=2;
                    if diff_val<=hr   
                        M_shu=M_shu+1;
                        lable(3)=1;
                    end                                             
                end

            end
        end
            
                    
        if case4
            if R_mark(x,y+1)==0

                diff_val=(Ycon(x,y,1)-Ycon(x,y,1))^2; 
                diff_val=diff_val+(Ycon(x,y+1,2)-Ycon(x,y,2))^2; 
                diff_val=diff_val+(Ycon(x,y+1,3)-Ycon(x,y,3))^2;                     
                    if diff_val<=hr
                        R_mark(x,y+1)=R_mark(x,y);
                        P_shu(R_num)=P_shu(R_num)+1;
                    end
                if ~accessed(x,y+1)                                                                 
                    accessed(x,y+1)=1;
                    unvisited_num=unvisited_num+1; 
                    lable(4)=2;
                    if diff_val<=hr         
                        M_shu=M_shu+1;
                        lable(4)=1;  
                    end                                             
                end

            end
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
        if (entries>1)
            if (M_shu>0)
                i=entries;
                while i>=2
                    Qxy(i+M_shu-1,1)=Qxy(i,1);
                    Qxy(i+M_shu-1,2)=Qxy(i,2);
                    i=i-1;
                end
            end
        end
        if (entries>1)
            if (M_shu<=0)  
                i=2;
                while i<=entries
                    Qxy(i+M_shu-1,1)=Qxy(i,1);
                    Qxy(i+M_shu-1,2)=Qxy(i,2);
                    i=i+1;
                end
            end
        end 

       
        entries=entries+M_shu-1;
               
        aa=1; 
        if (lable(1)==1)&&(M_shu>0)
             
            Qxy(aa,1)=x-1;
            Qxy(aa,2)=y;
            aa=aa+1;
            
        end
        if (lable(2)==1)&&(M_shu>0)
             
            Qxy(aa,1)=x;
            Qxy(aa,2)=y-1;
            aa=aa+1;
            
        end
        if (lable(3)==1)&&(M_shu>0)
             
            Qxy(aa,1)=x+1;
            Qxy(aa,2)=y;
            aa=aa+1;
            
        end
        if (lable(4)==1)&&(M_shu>0)
             
            Qxy(aa,1)=x;
            Qxy(aa,2)=y+1;

            
        end                              
              
        if (unvisited_num>0)&&(lable(1)==2)
             
            entries=entries+1;            
            Qxy(entries,1)=x-1;
            Qxy(entries,2)=y;
           
        end
        if (unvisited_num>0)&&(lable(2)==2)
            
            entries=entries+1;
            Qxy(entries,1)=x;
            Qxy(entries,2)=y-1;
            
        end        
        if (unvisited_num>0)&&(lable(3)==2)
             
            entries=entries+1;
            Qxy(entries,1)=x+1;
            Qxy(entries,2)=y; 
            
        end        
        if (unvisited_num>0)&&(lable(4)==2)
             
            entries=entries+1;
            Qxy(entries,1)=x;
            Qxy(entries,2)=y+1;
            
        end        
end

i=1;
val=zeros(R_num,3);
reg_num(R_num)=0;


while i<=row
    j=1;
    while j<=col   
        val(R_mark(i,j),1)=val(R_mark(i,j),1)+Ycon(i,j,1); 
        val(R_mark(i,j),2)=val(R_mark(i,j),2)+Ycon(i,j,2);
        val(R_mark(i,j),3)=val(R_mark(i,j),3)+Ycon(i,j,3);
        reg_num(R_mark(i,j))=reg_num(R_mark(i,j))+1;
        j=j+1;
    end
    i=i+1;
end

i=1;
while i<=R_num
    val(i,1)=val(i,1)/reg_num(i);   
    val(i,2)=val(i,2)/reg_num(i);
    val(i,3)=val(i,3)/reg_num(i);
    i=i+1;
end


i=1;    
while i<=row
    j=1;
    while j<=col   
        Ycon(i,j,1)=val(R_mark(i,j),1); 
        Ycon(i,j,2)=val(R_mark(i,j),2);
        Ycon(i,j,3)=val(R_mark(i,j),3);
        j=j+1;
    end
    i=i+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize
imgdata=imread(ButterflyPath);
orgimg=im2double(imgdata)*255;

[row col dimention]=size(orgimg);
orgluv=rgb2luv(orgimg);

Ycon=zeros(row,col,3);
Ycon_num=1;
Ycon_center(Ycon_num,1)=1;
Ycon_center(Ycon_num,2)=1;
itrationt=0;
flage=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hs=10;hr=30;
for i=1:row    
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

