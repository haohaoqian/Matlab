%1.2.1（1）播放单音
clear all;
close all;
clc;

seq1=[5,8,10,15,17];%曲谱序列
f0=220;%基准频率
freq=8000;%采样频率
amp=1;%幅度
for k=1:length(seq1)
    t=linspace(0,1-1/freq,freq);%生成时间
    temp=amp*sin(2*pi*f0*pow2(seq1(k)/12)*t);%生成乐音
    sound(temp,freq);%播放
    pause(1.5)
end