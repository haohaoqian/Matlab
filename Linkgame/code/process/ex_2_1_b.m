%2.1 分割屏幕截图 傅里叶变换方法
clear all;
close all;
clc;

pic=imread('graygroundtruth.jpg');%读取灰度图
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
[t,omg,FT,IFT]=prefourier([0,T-T/N],N,[0,500],10000);
F=FT*xa.';%傅里叶变换
figure(2);
hold on;
box on;
plot(omg/2/pi,abs(F)/max(abs(F)));%归一化并画出图像
xlabel('频率/Hz');
ylabel('幅度');
xlim([0,80]);
[~,b]=max(abs(F));%找出基波频率
width=round(2*pi*n/omg(b));%根据基波频率计算横向周期

F=FT*x.';%计算原灰度函数的频谱
phase=angle(F(b));%计算基波频率的相位
figure(3);
hold on;
box on;
t=[0:n];
base=abs(F(b))*cos(2*pi/width*t+phase);%生成基波函数
plot(x);
plot(base,'LineWidth',2);
xlabel('像素');
ylabel('灰度');
legend('原始波形','基波');
[~,l_margin]=max(base(1:width));%根据基波函数得到左侧空白距离

%计算纵向周期、顶部空白距离步骤完全相同，不再画出图像
y=mean(pic,2)-mean(mean(pic,2));
ya=bandpass(y,[5,30],m);

N=m;
T=1;
[t,omg,FT,IFT]=prefourier([0,T-T/N],N,[0,500],10000);
F=FT*ya;
[~,b]=max(abs(F));
height=round(2*pi*m/omg(b));

F=FT*y;
phase=angle(F(b));
t=[0:m];
base=abs(F(b))*cos(2*pi/height*t+phase);
[~,t_margin]=max(base(1:height));

N=floor((n-l_margin)/width);%计算每行方块数目
M=floor((m-t_margin)/height);%计算每列方块数目
figure;%画图显示
for k=1:N
    for t=1:M
        subplot(M,N,N*(t-1)+k);
        imshow(pic(t_margin+(t-1)*height+1:t_margin+t*height,l_margin+(k-1)*width+1:l_margin+k*width));
    end
end