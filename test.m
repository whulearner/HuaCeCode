%��͸ˮ��ʶ������
I=imread('D:/test.jpg');
BLUE=I(:,:,1);
GREEN=I(:,:,2);
RED=I(:,:,3);
%�ȼ�װ�к��Ⲩ��
NIR=GREEN; %���Ⲩ�η���ֵ
NVDI=double(NIR-RED)./double(NIR+RED); %NDVI ��һ����ֲֵ��ָ��
imshow(NVDI);
Binary=imbinarize(NVDI);
imshow(Binary);