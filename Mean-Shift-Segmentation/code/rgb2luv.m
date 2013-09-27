function luv=rgb2luv(orgimg)
[row col channel]=size(orgimg);
%%RGB to XYZ conversion
%This part convert code referrenced from the internet
prime=[0.1978 0.4683];
XYZ = [	 0.4125  0.3576  0.1804 ;
         0.2125  0.7154  0.0721 ;
         0.0193  0.1192  0.9502 ;];
luv=zeros(row,col,channel);

for i=1:row
    for j=1:col
        %RGB to XYZ
        x= XYZ(1,1)*orgimg(i,j,1) + XYZ(1,2)*orgimg(i,j,2) + XYZ(1,3)*orgimg(i,j,3);
        y= XYZ(2,1)*orgimg(i,j,1) + XYZ(2,2)*orgimg(i,j,2) + XYZ(2,3)*orgimg(i,j,3);
        z= XYZ(3,1)*orgimg(i,j,1) + XYZ(3,2)*orgimg(i,j,2) + XYZ(3,3)*orgimg(i,j,3);

        %XYZ to LUV
        luv(i,j,1)	= (903.3 * (y/255.0));
        if((y/255.0) > 0.008856)
            luv(i,j,1)	= (116.0 * ((y/255.0)^(1.0/3.0)) - 16.0);           
        end

        pu=4;
        pv=0.6;
        if (x+15*y+3*z) ~= 0
            pu=(4 * x) / (x+15*y+3*z);
            pv=(9 * y) / (x+15*y+3*z);            
        end
        
        luv(i,j,2) = (13 * luv(i,j,1) * (pu - prime(1)));
        luv(i,j,3) = (13 * luv(i,j,1) * (pv - prime(2)));
    end
end
fprintf('Finish coverting from rgb to luv formate\r\n');
