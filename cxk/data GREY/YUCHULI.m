% ����ת��Ϊ�Ҷ�ͼ��
clear
clc
path='..\data_RGB\';
fname=dir('..\data_RGB\*jpg');
length=length(fname);
for i=1:length
    image=imread([path,fname(i).name]);
    image=rgb2gray(image);
    imwrite(image,fname(i).name);
end