%1.2.2（8）分析基音与频率——傅里叶级数方法
clear all;
close all;
clc;

load('data/Guitar.mat');%载入数据并近似取一个周期
f=wave2proc(1:24);

T=0.0030375;%基音周期
omg=2*pi/T;%基频
N=24;%时域抽样点数
t=linspace(-T/2,T/2-T/N,N);%生成抽样时间
k=[-100:100].';%谐波次数

F=1/N*exp(-j*omg*k*t)*f;%求傅里叶级数
a0=F(101);
ak=F(102:201)+F(100:-1:1);%由指数形式转为三角形式
a=[a0;ak];
b=[0;1j*(F(102:201)-F(100:-1:1))];
stem(abs(a+1j*b)/max(abs(a+1j*b)));%归一化并画图像
xlabel('k');
ylabel('幅度');