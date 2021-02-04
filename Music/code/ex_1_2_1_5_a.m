%1.2.1（5）分析钢琴声音谐波
clear all;
close all;
clc;

y=audioread('data/钢琴.wav');

f=zeros(10000,1);
for k=1:10
    f(1000*k-999:1000*k)=y(3001:4000);%截取一小段并重复10次
end

N=10000;%时域采样点数
T=1.25;%时间范围
Omg=2*pi*N/T;%频域范围
omg=linspace(0,Omg,N).';%生成频域采样
t=linspace(0,T-T/N,N).';%生成时域采样
f1=f.*exp(-1j*omg(1)*t);%辅助函数
F1=T*exp(1j*omg(1)*t(1))/N*fft(f1);%快速傅里叶变换
F_fft=F1.*exp(-1j*omg*t(1));%由fft结果得到频谱
plot(omg/2/pi,abs(F_fft)/max(abs(F_fft)));%归一化并画出图像
xlabel('频率/Hz');
ylabel('幅度');
xlim([0,4000]);
ylim([0,1]);