function [R_mark,R_num,val,Ycon]=cluster_gray(Ycon,hr,hs)
[row col]=size(Ycon);
Ycon_kmean=zeros(row,col);

[row col channel] =size(Ycon);
Qxy(1,1)  =1; 
Qxy(1,2)  =1;                       

zero_r=zeros(hs,512+2*hs);
zero_c=zeros(512,hs);
Ycon1=[zero_c Ycon zero_c];
Ycon2=[zero_r;Ycon1;zero_r];
%size_aa=size(Ycon2);

R_mark(row,col)=0;
accessed(row,col)=0;
for i=1:row
    for j=1:col      
       R_mark(i,j)=0;
       accessed(i,j)=0;
    end
end
 
for iteration=1:2

    for i=(hs+1):(512+hs)
        for j=(hs+1):(512+hs)
            num=0;
            sum_val=0;
            for m=(i-hs):(i+hs)
                for n=(j-hs):(j+hs)
                    diff=abs(Ycon2(i,j)-Ycon2(m,n));
                    if diff<(hr+5)
                        num=num+1;
                        sum_val=sum_val+Ycon2(m,n);
                    end
                end
            end
            Ycon_kmean(i-hs,j-hs)=sum_val/num;
        end
    end
end
accessed(1,1)    =1;
R_mark(1,1) =1;                               


entries    =1;                                  
flag_queue=1;
R_num=1;                             
P_shu(R_num)=1;                 


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

                diff_val=(Ycon(x-1,y)-Ycon(x,y))^2;                     
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

                diff_val=(Ycon(x,y-1)-Ycon(x,y))^2;                     
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

                diff_val=(Ycon(x+1,y)-Ycon(x,y))^2;                     
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

                diff_val=(Ycon(x,y+1)-Ycon(x,y))^2;                     
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
            aa=aa+1;
            
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
for i=(hs+1):(512+hs)
        for j=(hs+1):(512+hs)
            num=0;
            sum_val=0;
            for m=(i-hs):(i+hs)
                for n=(j-hs):(j+hs)
                    diff=abs(Ycon2(i,j)-Ycon2(m,n));
                    if diff<(hr+5)
                        num=num+1;
                        sum_val=sum_val+Ycon2(m,n);
                    end
                end
            end
            Ycon_kmean(i-hs,j-hs)=sum_val/num;
        end
end
i=1;
val(R_num)=0;
reg_num(R_num)=0;

while i<=row
    j=1;
    while j<=col   
        val(R_mark(i,j))=val(R_mark(i,j))+Ycon(i,j);              
        reg_num(R_mark(i,j))=reg_num(R_mark(i,j))+1;
        j=j+1;
    end
    i=i+1;
end

i=1;
while i<=R_num
    val(i)=val(i)/reg_num(i);    
    i=i+1;
end
Ycon1=[zero_c Ycon zero_c];
Ycon2=[zero_r;Ycon1;zero_r];
for i=(hs+1):(512+hs)
        for j=(hs+1):(512+hs)
            num=0;
            sum_val=0;
            for m=(i-hs):(i+hs)
                for n=(j-hs):(j+hs)
                    diff=abs(Ycon2(i,j)-Ycon2(m,n));
                    if diff<(hr+5)
                        num=num+1;
                        sum_val=sum_val+Ycon2(m,n);
                    end
                end
            end
            Ycon_kmean(i-hs,j-hs)=sum_val/num;
        end
end

Ycon1=[zero_c Ycon zero_c];
Ycon2=[zero_r;Ycon1;zero_r];
i=1;    
while i<=row
    j=1;
    while j<=col   
        Ycon(i,j)=val(R_mark(i,j)); 
        j=j+1;
    end
    i=i+1;
end
for i=(hs+1):(512+hs)
        for j=(hs+1):(512+hs)
            num=0;
            sum_val=0;
            for m=(i-hs):(i+hs)
                for n=(j-hs):(j+hs)
                    diff=abs(Ycon2(i,j)-Ycon2(m,n));
                    if diff<(hr*2)
                        num=num+1;
                        sum_val=sum_val+Ycon2(m,n);
                    end
                end
            end
            Ycon_kmean(i-hs,j-hs)=sum_val/num;
        end
end

