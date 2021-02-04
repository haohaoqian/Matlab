%1.2.1（3）升高与降低音调
clear all;
close all;
clc;

x=audioread('东方红2.wav').';%载入合成好的音乐
freq=8000;%原采样频率
sound(x,0.5*freq);%慢速播放降八度
pause(8);
sound(x,2*freq);%快速播放升八度
audiowrite('data/东方红_升八度.wav',x,2*freq);
pause(2);
y1=resample(x,26487,25000);%升高采样率，降半音
sound(y1,freq);
pause(4);
audiowrite('data/东方红_降半音.wav',y1,freq);
y2=resample(x,25000,26487);%降低采样率，升半音
sound(y2,freq);
pause(4);
audiowrite('data/东方红_升半音.wav',y1,freq);