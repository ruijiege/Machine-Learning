function rgb=luv2rgb(luv)
%%%XYZ to RGB conversion
%This part convert code referrenced from the internet

RGB = [3.2405   -1.5371  -0.4985 ;
       -0.9693   1.8760   0.0416;
       0.0556   -0.2040   1.0573	];

Up	= 0.19784977571475;
Vp	= 0.46834507665248;


[row col chan]=size(luv);

for i=1:row
    for j=1:col
        if (luv(i,j,1)<0.1)
            rgb(i,j,1)=0;
            rgb(i,j,2)=0;
            rgb(i,j,3)=0;
        else
            Y_val =((luv(i,j,1) + 16.0) / 116.0)^3;
            if (luv(i,j,1)<8)
                Y_val =luv(i,j,1) / 903.3;
            end
            upe = luv(i,j,2) / (13 * luv(i,j,1)) + Up;
            vpe = luv(i,j,3) / (13 * luv(i,j,1)) + Vp;
            X_val = 9 * upe * Y_val / (4 * vpe);
            Z_val = (12 - 3 * upe - 20 * vpe) * Y_val / (4 * vpe);
            for k=1:3
                rgb(i,j,k) =uint8((RGB(k,1)*X_val + RGB(k,2)*Y_val + RGB(k,3)*Z_val)*255.0);            
            end
            for k=1:3
                if rgb(i,j,k)>255
                    rgb(i,j,k)=255;
                elseif rgb(i,j,k)<0
                    rgb(i,j,k)=0;
                end
            end
        end
    end
end
            
