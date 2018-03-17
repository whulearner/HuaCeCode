%不透水面识别试算
I=imread('D:/test.jpg');
BLUE=I(:,:,1);
GREEN=I(:,:,2);
RED=I(:,:,3);
%先假装有红外波段
NIR=GREEN; %红外波段反射值
NVDI=double(NIR-RED)./double(NIR+RED); %NDVI 归一化差值植被指数
imshow(NVDI);
Binary=imbinarize(NVDI);
imshow(Binary);