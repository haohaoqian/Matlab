%1.2.3（11）用真实谐波合成《东方红》
clear all;
close all;
clc;

seq=[3,3,5,-2,-4,-4,-7,-2];%曲谱序列
time=[0.5,0.25,0.25,1,0.5,0.25,0.25,1];%时值(s)
overlap=[0.2,0.3,0.2,0.2,0.2,0.3,0.2,0.2];%迭接时间(s)
harmonic=[1.0000,0.7272,0.5067,0,0,0,0,0,0,0;
    1.0000,0.7272,0.5067,0,0,0,0,0,0,0;
    1.0000,0.7573,0.2488,0.1438,0.1306,0.1447,0,0,0.1110,0;
    0.4201,1.0000,0.4718,0,0,0.0960,0.1324,0,0,0;
    1.0000,0.2729,0,0.1483,0,0.1732,0,0.1242,0,0;
    1.0000,0.2729,0,0.1483,0,0.1732,0,0.1242,0,0;
    0.3529,1.0000,0.3729,0.6826,0,0.1600,0,0,0,0;
    0.4201,1.0000,0.4718,0,0,0.0960,0.1324,0,0,0];%各音符谐波分量
f0=220;%基准频率
freq=8000;%采样频率
amp=1;%幅度
output=zeros(1,freq*(sum(time)+overlap(length(overlap))));%输出向量
position=1;%辅助指针
for k=1:length(time)
    t=linspace(0,time(k)+overlap(k)-1/freq,freq*(time(k)+overlap(k)));%生成时间
    temp=harmonic(k,1)*amp*sin(2*pi*f0*pow2(seq(k)/12)*t);%生成乐音
    temp=temp+harmonic(k,2)*amp*sin(2*pi*2*f0*pow2(seq(k)/12)*t);%高次谐波
    temp=temp+harmonic(k,3)*amp*sin(2*pi*3*f0*pow2(seq(k)/12)*t);
    temp=temp+harmonic(k,4)*amp*sin(2*pi*4*f0*pow2(seq(k)/12)*t);
    temp=temp+harmonic(k,5)*amp*sin(2*pi*5*f0*pow2(seq(k)/12)*t);
    temp=temp+harmonic(k,6)*amp*sin(2*pi*6*f0*pow2(seq(k)/12)*t);
    temp=temp+harmonic(k,7)*amp*sin(2*pi*7*f0*pow2(seq(k)/12)*t);
    temp=temp+harmonic(k,8)*amp*sin(2*pi*8*f0*pow2(seq(k)/12)*t);
    temp=temp+harmonic(k,9)*amp*sin(2*pi*9*f0*pow2(seq(k)/12)*t);
    temp=temp+harmonic(k,10)*amp*sin(2*pi*10*f0*pow2(seq(k)/12)*t);
    cover=[-100*(t(1:0.1*time(k)*freq-1)/time(k)).^2+20*(t(1:0.1*time(k)*freq-1)/time(k))...
        ,1.15652*exp(-2*(t(0.1*time(k)*freq:freq*(time(k)+overlap(k)))-0.1*time(k))/(0.9*time(k)+overlap(k)))-0.15652];%生成包络
    output(position:position+freq*(time(k)+overlap(k))-1)=output(position:position+freq*(time(k)+overlap(k))-1)+cover.*temp;%添加乐音
    position=position+freq*time(k);%移动指针 
end
output=output/max(abs(output));%归一化
sound(output,freq);%播放
audiowrite('data/东方红6.wav',output,freq)%保存