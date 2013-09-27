function [Ycon_kmean,cluster_num]=kmeancluster(Ycon,hr,hs)
hs=hs-5;
[row col]=size(Ycon);
Ycon_kmean=zeros(row,col);
mark=zeros(row+2*hs,col+2*hs);
cluster_num=1;
Yvalue(cluster_num)=0;

zero_r=zeros(hs,512+2*hs);
zero_c=zeros(512,hs);
Ycon1=[zero_c Ycon zero_c];
Ycon2=[zero_r;Ycon1;zero_r];
%size_aa=size(Ycon2);

    for i=(hs+1):(512+hs)
        for j=(hs+1):(512+hs)
            if ~mark(i,j)
                i
                cluster_num=cluster_num+1;
                mark(i,j)=cluster_num;
                for m=(i-hs):(i+hs)
                    for n=(j-hs):(j+hs)
                        if ~mark(m,n)
                            diff=abs(Ycon2(i,j)-Ycon2(m,n));
                            if diff<(hr)
                                mark(m,n)=mark(i,j);
                            end
                        end
                    end
                end
                Yvalue(cluster_num)=Ycon2(i,j);
                for m=(i-hs):(i+hs)
                    for n=(j-hs):(j+hs)

                        if mark(i,j)==cluster_num
                            Ycon_kmean(i,j)=Yvalue(cluster_num);
                            Ycon2(m,n)=Ycon2(i,j);
                        end
                    end

                end
            else
                for m=(i-hs):(i+hs)
                    for n=(j-hs):(j+hs)
                        if ~mark(m,n)
                            diff=abs(Ycon2(i,j)-Ycon2(m,n));
                            if diff<(hr)
                                mark(m,n)=mark(i,j);
                            end
                        end
                    end
                end
                Yvalue(cluster_num)=Ycon2(i,j);
                for m=(i-hs):(i+hs)
                    for n=(j-hs):(j+hs)

                        if mark(i,j)==cluster_num
                            Ycon_kmean(i,j)=Yvalue(cluster_num);
                            Ycon2(m,n)=Ycon2(i,j);
                        end
                    end

                end
            end
        end
    end
    
    
