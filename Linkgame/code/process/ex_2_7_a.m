%2.7 分割摄像头捕获彩色图像
clear all;
close all;
clc;

pic0=imread('colorcapture.jpg');%读取彩色图
[m,n,~]=size(pic0);

width0=0;
height0=0;
l_margin0=0;
t_margin0=0;

figure(1);
hold on;
box on;
xlabel('像素');
ylabel('数值');
figure(2);
hold on;
box on;
xlabel('频率');
ylabel('幅度');
for ch=1:3
    figure(1);
    pic=pic0(:,:,ch);
    x=mean(pic,1)-mean(mean(pic,1));%按行平均，除去直流分量
    plot(x);
    xa=bandpass(x,[5,30],n);%带通滤波
    
    figure(2);
    N=n;%时域采样点数
    T=1;%时间范围
    [t,omg,FT,IFT]=prefourier([0,T-T/N],N,[0,500],10000);
    F=FT*xa.';%傅里叶变换
    [~,b]=max(abs(F));%找出基波频率
    width=round(2*pi*n/omg(b));%根据基波频率计算横向周期
    width0=width0+width;
    plot(omg/2/pi,abs(F)/max(abs(F)));

    F=FT*x.';%计算原函数的频谱
    phase=angle(F(b));%计算基波频率的相位
    t=[0:n];
    base=abs(F(b))*cos(2*pi/width*t+phase);%生成基波函数
    [~,l_margin]=max(base(1:width));%根据基波函数得到左侧空白距离
    l_margin0=l_margin0+l_margin;

    %计算纵向周期、顶部空白距离步骤完全相同，不再画出图像
    y=mean(pic,2)-mean(mean(pic,2));
    ya=bandpass(y,[5,30],m);

    N=m;
    T=1;
    [t,omg,FT,IFT]=prefourier([0,T-T/N],N,[0,500],10000);
    F=FT*ya;
    [~,b]=max(abs(F));
    height=round(2*pi*m/omg(b));
    height0=height0+height;

    F=FT*y;
    phase=angle(F(b));
    t=[0:m];
    base=abs(F(b))*cos(2*pi/height*t+phase);
    [~,t_margin]=max(base(1:height));
    t_margin0=t_margin0+t_margin;
end
figure(1);
legend('R','G','B');
figure(2);
legend('R','G','B');

width0=round(width0/3);%计算平均值
height0=round(height0/3);
l_margin0=round(l_margin0/3);
t_margin0=round(t_margin0/3);

N=floor((n-l_margin0)/width0);%计算每行方块数目
M=floor((m-t_margin0)/height0);%计算每列方块数目
spilit={};
figure;%画图显示
for k=1:N
    for t=1:M
        subplot(M,N,N*(t-1)+k);
        imshow(pic0(t_margin0+(t-1)*height0+1:t_margin0+t*height0,l_margin0+(k-1)*width0+1:l_margin0+k*width0,:));
        spilit{t,k}=pic0(t_margin0+(t-1)*height0+1:t_margin0+t*height0,l_margin0+(k-1)*width0+1:l_margin0+k*width0,:);
    end
end
save('../data/spilit_c.mat','spilit');%保存分割后的图片
info=[l_margin0,t_margin0,width0,height0];
save('../data/info_c.mat','info');%保存分割尺寸