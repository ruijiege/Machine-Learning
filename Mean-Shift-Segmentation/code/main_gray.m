%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Ruijie Ge    50062092
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear;clc;
HousePath='./House.jpg';
img=imread(HousePath);
%img=imread(ButterflyPath);
%imshow(img)
orgimg=im2double(img)*255;
figure(1);
imshow(orgimg,[]);


hs=7;hr=10;
[Ycon,Ycon_num,Ycon_center]=filtering_gray(HousePath,hs,hr);
figure(2);
imshow(Ycon,[]);
fprintf('filtering done\r\n');

%[Ycon,cluster_num]=kmeancluster(Ycon,hr,hs);
%cluster_num
%figure(3);
%imshow(Ycon,[]);
%fprintf('cluster done\r\n');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[region_lab,region_num,val,Ycon]=cluster_gray(Ycon,hr,hs);

figure(3);
imshow(Ycon,[]);
fprintf('cluster done\r\n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%