%take an image, then extract RGB-Y channels
clear;
clc;
[filename pathname]=uigetfile({'*.jpg'},'File Selector',...
    ...%'C:\Users\DEll\Desktop\ColorSpatialDist\sumOfMaps_mag_ours\');
    'E:\Master_Work\Saliency_Maps\1000_Original');
if isequal(filename,0) || isequal(pathname,0);
    return; end %Pressed Cancel


imagePath1=strcat(pathname,filename);

img= imread(imagePath1);
[h,w,c]=size(img);

R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);
% figure,imshow(R);
% figure,imshow(G);
% figure,imshow(B);
R1=abs(R-(G+B)/2);
G1=abs(G-(R+B)/2);
B1=abs(B-(R+G)/2);
Y=abs((R+G)/2-abs(R-G)/2-B);

% figure,imshow(R1);
% figure,imshow(G1);
% figure,imshow(B1);
% figure,imshow(Y);
%vector
v=[];
%k=zeros(h,w);
% meanR=mean2(R1);
% meanG=mean2(G1);
% meanB=mean2(B1);
% meanY=mean2(Y);

%variance of every channel
v(1)=var(double (R1(:) ));
v(2)=var(double (G1(:) ));
v(3)=var(double (B1(:) ));
v(4)=var(double (Y(:) ));
%Largest variance and its index
% maxm=v(1);
% for i=2:length(v)
%     if maxm < v(i)
%         maxm=v(i);
%         index=i;
%     end
%     
% end
%structur each channel with each crossponding variance
% S.('v1')={R1,v(1)};
% S.('v2')={G1,v(2)};
% S.('v3')={B1,v(3)};
% S.('v4')={Y,v(4

%largert variance and its index
[maxm, index]=max(v);
%Struct of two fiels 
field1='channel';
field2='variance';
value1={R1,G1,B1,Y};
value2={v(1),v(2),v(3),v(4)};
S=struct(field1,value1,field2,value2);

%informative channel is the channel that have largest variance
ch=S(index).channel;
% figure,imshow(ch);
%compute saliency map
mean_ch=mean2(ch);
salmap=zeros(h,w);
for j=1:h
    for k=1:w
        salmap(j,k)=ch(j,k)- mean_ch;
    end
end

%normalization step
% salmap=salmap-min(salmap(:));
% salmap=salmap/max(salmap(:));
% figure,imshow(salmap);

