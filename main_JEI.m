% addpath('./tools')
I1 = imread('disk1.gif');
I2 = imread('disk2.gif');
I(:,:,1) = I1;
I(:,:,2) = I2;
tic
F_ffif = FFIF(double(I),6,0.06);
time_ffif = toc;
% main_measure_fusion(I1,I2,uint8(F_ffif))