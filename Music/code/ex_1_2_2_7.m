%1.2.2（7）预处理realwave
clear all;
close all;
clc;

load('data/Guitar.mat');%载入数据
y=resample(realwave,2430,243);%插值增加采样点
y_bar=zeros(243,1);
for k=1:10
    y_bar=y_bar+y(243*k-242:243*k);%取一个周期累加10次
end
y_bar=y_bar/10;%取平均
for k=1:10
    y(243*k-242:243*k)=y_bar;%周期延拓
end
y=resample(y,243,2430);%恢复243个采样点
error=y-wave2proc;%计算误差
figure;
subplot(1,2,1);
stem(error);
xlabel('采样点');
ylabel('error');
subplot(1,2,2);
error=error./wave2proc;%计算相对误差
stem(error);
xlabel('采样点');
ylabel('relatively error');