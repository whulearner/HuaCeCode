%��͸ˮ��ʶ������
I=imread('D:/test.jpg');
BLUE=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band2.tif');
GREEN=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band3.tif');
RED=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band4.tif');
NIR=imread('D:\huace\LC08_L1TP_122044_20180212_20180222_01_T1_sr_band5.tif'); %���Ⲩ�η���ֵ
NVDI=double(NIR-RED)./double(NIR+RED)+0.1; %NDVI ��һ����ֲֵ��ָ��
maxB=max(max(BLUE));
maxG=max(max(GREEN));
maxR=max(max(RED));
dBLue=double(BLUE);
dGREEN=double(GREEN);
dRED=double(RED);

dI(:,:,1)=(dBLue+9999*ones(7691,7531,1))*255/double(maxB+9999);
dI(:,:,2)=(dGREEN+9999*ones(7691,7531,1))*255/double(maxG+9999);
dI(:,:,3)=(dRED+9999*ones(7691,7531,1))*255/double(maxR+9999);
Binary=imbinarize(NVDI);
imshow(dI);
%imshow(Binary);
