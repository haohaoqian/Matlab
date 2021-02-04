%1.2.1（1）初步合成东方红
clear all;
close all;
clc;

seq=[15,15,17,10,8,8,5,10];%曲谱序列
time=[0.5,0.25,0.25,1,0.5,0.25,0.25,1];%时值(s)
inter=[0.1,0.05,0.1,0.1,0.1,0.05,0.1,0.1];%间隔时间(s)
f0=220;%基准频率
freq=8000;%采样频率
amp=1;%幅度
output=zeros(1,freq*sum(time)+freq*sum(inter));%输出向量
position=1;%辅助指针
for k=1:length(time)
    t=linspace(0,time(k)-1/freq,freq*time(k));%生成时间
    temp=amp*sin(2*pi*f0*pow2(seq(k)/12)*t);%生成乐音
    output(position:position+freq*time(k)-1)=temp;%添加乐音
    position=position+freq*time(k);%移动指针
    output(position:position+freq*inter(k)-1)=zeros(1,freq*inter(k));%添加间隔
    position=position+freq*inter(k);%移动指针
end
sound(output,freq);%播放
audiowrite('data/东方红1.wav',output,freq)%保存