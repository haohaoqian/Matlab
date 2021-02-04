%1.2.2（8）分析基音与频率——快速傅里叶变换方法
clear all;
close all;
clc;

load('data/Guitar.mat');%载入数据
f=zeros(10*length(wave2proc),1);
for k=1:10
    f(243*k-242:243*k)=wave2proc;%重复10次
end

N=2430;%时域采样点数
T=0.30375;%时间范围
Omg=2*pi*N/T;%频域范围
omg=linspace(0,Omg,N).';%生成频域采样
t=linspace(0,T-T/N,N).';%生成时域采样
f1=f.*exp(-1j*omg(1)*t);%辅助函数
F1=T*exp(1j*omg(1)*t(1))/N*fft(f1);%快速傅里叶变换
F_fft=F1.*exp(-1j*omg*t(1));%由fft结果得到频谱
peak=locatepeak(omg,abs(F_fft)/max(abs(F_fft)),0.03,50);%定位峰值
peak(:,1)=peak(:,1)/2/pi;%频率单位转换为Hz
figure;
hold on;
box on;
plot(omg/2/pi,abs(F_fft)/max(abs(F_fft)));%归一化并画出图像
xlabel('频率/Hz');
ylabel('幅度');
xlim([0,4000]);
ylim([0,1]);
scatter(peak(:,1),peak(:,2),'MarkerFaceColor','g');%标记峰值