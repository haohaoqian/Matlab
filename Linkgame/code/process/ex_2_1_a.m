%2.1 分割屏幕截图 FFT方法
clear all;
close all;
clc;

pic=imread('graygroundtruth.jpg');
[m,n]=size(pic);

figure(1);
hold on;
box on;
x=mean(pic,1)-mean(mean(pic,1));%按行平均，除去直流分量
xa=bandpass(x,[5,30],n);%带通滤波
plot(x);
plot(xa,'LineWidth',2);
xlabel('像素');
ylabel('灰度');
legend('原始波形','带通波形');

N=n;%时域采样点数
T=1;%时间范围
Omg=2*pi*N/T;%频域范围
omg=linspace(0,Omg,N);%生成频域采样
t=linspace(0,T-T/N,N);%生成时域采样
f1=xa.*exp(-1j*omg(1)*t);%辅助函数
F1=T*exp(1j*omg(1)*t(1))/N*fft(f1);%快速傅里叶变换
F_fft=F1.*exp(-1j*omg*t(1));%由fft结果得到频谱
figure(2);
hold on;
box on;
plot(omg/2/pi,abs(F_fft)/max(abs(F_fft)));%归一化并画出图像
xlabel('频率/Hz');
ylabel('幅度');
xlim([0,80]);
[~,b]=max(abs(F_fft(1:Omg/4/pi)));
width=round(2*pi*n/omg(b));

N=n;%时域采样点数
T=1;%时间范围
Omg=2*pi*N/T;%频域范围
omg=linspace(0,Omg,N);%生成频域采样
t=linspace(0,T-T/N,N);%生成时域采样
f1=x.*exp(-1j*omg(1)*t);%辅助函数
F1=T*exp(1j*omg(1)*t(1))/N*fft(f1);%快速傅里叶变换
F_fft=F1.*exp(-1j*omg*t(1));%由fft结果得到频谱
phase=angle(F_fft(b));
figure(3);
hold on;
box on;
t=[0:n];
base=abs(F_fft(b))*cos(2*pi/width*t+phase);%生成基波函数
plot(x);
plot(base,'LineWidth',2);
xlabel('像素');
ylabel('灰度');
legend('原始波形','基波');
[~,l_margin]=max(base(1:width));%根据基波函数得到左侧空白距离

y=mean(pic,2)-mean(mean(pic,2));
ya=bandpass(y,[5,20],m);

N=m;%时域采样点数
T=1;%时间范围
Omg=2*pi*N/T;%频域范围
omg=linspace(0,Omg,N);%生成频域采样
t=linspace(0,T-T/N,N);%生成时域采样
f1=ya.'.*exp(-1j*omg(1)*t);%辅助函数
F1=T*exp(1j*omg(1)*t(1))/N*fft(f1);%快速傅里叶变换
F_fft=F1.*exp(-1j*omg*t(1));%由fft结果得到频谱
[~,b]=max(abs(F_fft(1:Omg/4/pi)));
height=round(2*pi*m/omg(b));

f1=y.'.*exp(-1j*omg(1)*t);%辅助函数
F1=T*exp(1j*omg(1)*t(1))/N*fft(f1);%快速傅里叶变换
F_fft=F1.*exp(-1j*omg*t(1));%由fft结果得到频谱
phase=angle(F_fft(b));
t=[0:m];
base=abs(F_fft(b))*cos(2*pi/height*t+phase);
[~,t_margin]=max(base(1:height));

N=floor((n-l_margin)/width);
M=floor((m-t_margin)/height);
figure;
for k=1:N
    for t=1:M
        subplot(M,N,N*(t-1)+k);
        imshow(pic(t_margin+(t-1)*height+1:t_margin+t*height,l_margin+(k-1)*width+1:l_margin+k*width));
    end
end