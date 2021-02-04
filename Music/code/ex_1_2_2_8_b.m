%1.2.2（8）分析基音与频率——傅里叶变换方法
clear all;
close all;
clc;

load('data/Guitar.mat');%载入数据
f=zeros(10*length(wave2proc),1);
for k=1:10
    f(243*k-242:243*k)=wave2proc;%重复10次
end

[t,omg,FT,IFT]=prefourier([0,0.30375-0.30375/2430],2430,[-25000,25000],100000);
F=FT*f;
plot(omg/2/pi,abs(F)/max(abs(F)));%归一化并画图
xlabel('频率/Hz');
ylabel('幅度');
xlim([0,4000]);