%1.2.1（2）增加包络与音符迭接
clear all;
close all;
clc;

seq=[15,15,17,10,8,8,5,10];%曲谱序列
time=[0.5,0.25,0.25,1,0.5,0.25,0.25,1];%时值(s)
overlap=[0.2,0.3,0.2,0.2,0.2,0.3,0.2,0.2];%迭接时间(s)
f0=220;%基准频率
freq=8000;%采样频率
amp=1;%幅度
output=zeros(1,freq*(sum(time)+overlap(length(overlap))));%输出向量
position=1;%辅助指针
for k=1:length(time)
    t=linspace(0,time(k)+overlap(k)-1/freq,freq*(time(k)+overlap(k)));%生成时间
    temp=amp*sin(2*pi*f0*pow2(seq(k)/12)*t);%生成乐音
    cover=[-100*(t(1:0.1*time(k)*freq-1)/time(k)).^2+20*(t(1:0.1*time(k)*freq-1)/time(k))...
        ,1.15652*exp(-2*(t(0.1*time(k)*freq:freq*(time(k)+overlap(k)))-0.1*time(k))/(0.9*time(k)+overlap(k)))-0.15652];%生成包络
    output(position:position+freq*(time(k)+overlap(k))-1)=output(position:position+freq*(time(k)+overlap(k))-1)+cover.*temp;%添加乐音
    position=position+freq*time(k);%移动指针 
end
output=output/max(abs(output));%归一化
sound(output,freq);%播放
audiowrite('data/东方红2.wav',output,freq)%保存