%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Ruijie Ge    50062092
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear;clc;
ButterflyPath='./Butterfly.jpg';
img=imread(ButterflyPath);
%img=imread(ButterflyPath);
%imshow(img)
orgimg=im2double(img);
figure(1);
imshow(orgimg);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hs=7;hr=10;
[Ycon,Ycon_num,Ycon_center]=filtering_color(ButterflyPath,hs,hr);
%Ycon
Ycon=luv2rgb(Ycon);
figure(2);
imshow(Ycon);
fprintf('filtering_color done\r\n');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[R_mark,R_num,val,Ycon]=cluster_color(Ycon,ButterflyPath,hs,hr);

%Ycon=convert_luv2rgb(Ycon);
%figure(3);
%imshow(Ycon);
%fprintf('cluster_color done\r\n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%