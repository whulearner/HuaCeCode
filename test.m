%不透水面识别试算
% I=imread('D:/test.jpg');
% BLUE=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band2.tif');
% GREEN=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band3.tif');
RED=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band4.tif');
NIR=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band5.tif'); %红外波段反射值
NVDI=double(NIR-RED)./double(NIR+RED)+0.1; %NDVI 归一化差值植被指数
SWIR2=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band7.tif'); %读取中红外波段反射值

% maxB=max(max(BLUE));
% maxG=max(max(GREEN));
% maxR=max(max(RED));
% dBLUE=(double(BLUE)+9999*ones(7691,7531,1))*255/(9999+double(maxB));
% dGREEN=(double(GREEN)+9999*ones(7691,7531,1))*255/(9999+double(maxG));
% dRED=(double(RED)+9999*ones(7691,7531,1))*255/(9999+double(maxR));
% dI(:,:,1)=dBLUE;
% dI(:,:,2)=dGREEN;
% dI(:,:,3)=dRED;
Binary=imbinarize(NVDI);
% imshow(dI);
imshow(Binary);
