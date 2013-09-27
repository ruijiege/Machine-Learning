function [Ycon]=mscluster(Ycon,Ycon_num,Ycon_center)


Ylabel=zeros(1,Ycon_num);
Ylabel(1,1)=1;
Ylabel_num=1;
Ymark=zeros(1,Ycon_num);
label_pnum=zeros(1,170000);
sum_label_val=0;
ave_label_val=zeros(1,170000);


for u=1:Ycon_num
    if Ymark(1,u)==0
        %flag_first=1;
        Ylabel(1,u)=Ylabel_num;
        for v=u:Ycon_num
            
            if ((Ycon_center(u,1)-Ycon_center(v,1))<2)&&((Ycon_center(u,2)-Ycon_center(v,2))<2)
                Ylabel(1,v)=Ylabel(1,u);
                
                %if flag_first
                   % first=Ycon(Ycon_center(v,1),Ycon_center(v,2));
                   % flag_first=0;
                %end
                label_pnum(1,Ylabel_num)=label_pnum(1,Ylabel_num)+1;
                sum_label_val=sum_label_val+Ycon(Ycon_center(v,1),Ycon_center(v,2));
                %Ycon(Ycon_center(v,1),Ycon_center(v,2))=first;
                Ymark(1,v)=1;
                
            end
        end
        ave_label_val(1,Ylabel_num)=sum_label_val/label_pnum(1,Ylabel_num);
        sum_label_val=0;
        Ylabel_num=Ylabel_num+1;
    end
end

Ylabel_num2=1;
for u=1:Ycon_num
    for v=u:Ycon_num            
        if ((Ycon_center(u,1)-Ycon_center(v,1))<2)&&((Ycon_center(u,2)-Ycon_center(v,2))<2)
            Ycon(Ycon_center(v,1),Ycon_center(v,2))=ave_label_val(1,Ylabel_num2);             
        end
    end
    Ylabel_num2=Ylabel_num2+1;
  
end

%for q=1:Ylabel_num
%    for f=1:label_pnum(1,q)
%        Ycon(Ycon_center(f,1),Ycon_center(f,2))=ave_label_val(1,Ylabel_num);
%    end
 
%end


