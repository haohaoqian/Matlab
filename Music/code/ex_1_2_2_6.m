%1.2.2（6）分析fmt.wav文件中的音乐
clear all;
close all;
clc;

y=audioread('data/fmt.wav');%读取音乐文件
sound(y,8000);%播放
plot(y);%绘制波形
xlabel('采样点');
ylabel('幅度');
[t,omg,FT,IFT]=prefourier([0,0.5-0.5/4000],4000,[-10000,10000],50000);
F=FT*y(5001:9000);
plot(omg,abs(F));
xlabel('\omega')
ylabel('幅度');