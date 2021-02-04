%1.2.2（9）自动提取乐谱
clear all;
close all;
clc;

y=audioread('data/fmt.wav');
t=[1:length(y)].';%生成时间序列
peak=locatepeak(t,y,0.02,150);%调用locatepeak函数寻找时域峰值，确定包络
figure;
hold on;
box on;
xlabel('采样点')
ylabel('幅度')
plot(y);
plot(peak(:,1),peak(:,2),'LineWidth',2);%画出原始包络
peak=lowpass(peak,0.6);%对原始包络低通滤波
plot(peak(1:400,1),peak(1:400,2),'LineWidth',2);%画出滤波后的包络

start=locatepeak(peak(1:400,1),peak(1:400,2),0.1,1000);%定位音调起始点
time_last=zeros(length(start(:,1)),1);%各音调持续时间
for h=1:length(start(:,1))-1
    time_last(h)=(start(h+1,1)-start(h,1))/8000;
end
time_last(length(start(:,1)))=(length(y)-start(length(start(:,1))-1,1))/8000;
scatter(start(:,1),start(:,2),'MarkerFaceColor','g');%画出起始点
legend('时域波形','原始包络','低通滤波后包络','音调起始点');

note=zeros(length(start(:,1)),4,12);
% 储存音符信息，每页表示一个音调，每行表示一个音符，第一列为基波频率，
% 第2-11列依次为基波、2-10次谐波的相对强度，第12列为该音符相对于220Hz偏移的半音数
for k=1:length(start(:,1))%逐个分析音调
    sample0=y(start(k,1)+1000:start(k,1)+1999);%从中间位置取样长度为1000的片段
    sample=zeros(100000,1);
    for h=1:100
        sample(1000*h-999:1000*h)=sample0;%重复100次提高精确度
    end
    N=100000;%时域采样点数
    T=12.5;%时间范围
    Omg=2*pi*N/T;%频域范围
    omg=linspace(0,Omg,N).';%生成频域采样
    t=linspace(0,T-T/N,N).';%生成时域采样
    f1=sample.*exp(-1j*omg(1)*t);%辅助函数
    F1=T*exp(1j*omg(1)*t(1))/N*fft(f1);%快速傅里叶变换
    F_fft=F1.*exp(-1j*omg*t(1));%由fft结果得到频谱
    peak=locatepeak(omg,abs(F_fft),0.04,150);%定位峰值
    peak=peak(1:length(peak(:,1))/2,:);
    peak(:,1)=peak(:,1)/2/pi;%频率单位转换为Hz
    
    figure;
    hold on;
    box on;
    plot(omg/2/pi,abs(F_fft));
    scatter(peak(:,1),peak(:,2),'MarkerFaceColor','g');%标记峰值
    xlabel('频率/Hz');
    ylabel('幅度');
    xlim([0,4000]);
    ylim([0,1]);
    
    note_temp=zeros(20,12);
    % 临时储存音符信息，每行表示一个音符，第一列为基波频率，
    % 第2-11列依次为基波、2-10次谐波的相对强度，第12列为各阶谐波的能量和
    pointer=1;%辅助指针
    for h=1:length(peak(:,1))
        flag=0;%标记是否已经有该音符
        for m=1:20
            if note_temp(m,1)~=0 & abs(round(peak(h,1)/note_temp(m,1))*note_temp(m,1)-peak(h,1))/peak(h,1)<=0.05
                order=round(peak(h,1)/note_temp(m,1));%计算谐波阶次
                if order<=10%仅考虑前10阶谐波
                    note_temp(m,order+1)=peak(h,2);%如果为已有音符的谐波，则存入谐波分量中
                end
                flag=1;
            end
        end
        if flag==0%目前没有的音符存入基波分量中
            note_temp(pointer,1)=peak(h,1);
            note_temp(pointer,2)=peak(h,2);
            pointer=pointer+1;%移动辅助指针
        end
    end
    note_temp(:,12)=sum(note_temp(:,2:11),2);%求每个音符谐波能量和，存入第12列
    for h=1:4%选取总能量最大、且大于一定阈值的四个音符作为最终结果
        [max_value,max_pointer]=max(note_temp(:,12));
        if max_value>=0
            note(k,h,1:11)=note_temp(max_pointer,1:11);
            note(k,h,12)=round(12*log2(note(k,h,1)/220));
            note_temp(max_pointer,:)=[];
        end
    end
end
save ('data/time_last.mat','time_last');
save ('data/note.mat','note');