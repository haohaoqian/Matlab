%2.7 计算方块相似性
clear all;
close all;
clc;

pic=load('../data/spilit_c.mat').spilit;
[M,N]=size(pic);
[height,width,~]=size(pic{1,1});
%% 高通滤波
pic_h={};
h_c=(1+height)/2;%计算中心位置
w_c=(1+width)/2;
passband=2;%通带半径
for m=1:M
    for n=1:N
        temp0=im2double(pic{m,n});
        for ch=1:3
            temp=temp0(:,:,ch);%转化为double型
            temp=fftshift(fft2(temp));%傅里叶变换并将零频率移动到中心
            for x=1:floor(width/2)
                x2=x^2;
                for y=1:floor(height/2)
                    y2=y^2;
                    if x2+y2<passband^2%位于通带外则截断
                        temp(floor(h_c+y),floor(w_c+x))=0;%实信号频谱对称，可以由一个象限填充其他
                        temp(floor(h_c+y),ceil(w_c-x))=0;
                        temp(ceil(h_c-y),floor(w_c+x))=0;
                        temp(ceil(h_c-y),ceil(w_c-x))=0;
                    end
                end
            end
            temp=real(ifft2(ifftshift(temp)));%傅里叶逆变换得到处理后的图像
            temp0(:,:,ch)=temp;
        end
        pic_h{m,n}=temp0;
    end
end
%% 计算色彩直方图
co={};%逐个方块计算色彩直方图
for m=1:M
    for n=1:N
        co{m,n}=color(pic{m,n},3);
    end
end
%% 计算相关系数
%RGB通道分别做匹配滤波
%匹配滤波结果与色彩直方图结合
sim_1=zeros(M,N,M,N);
sim_c=zeros(M,N,M,N);
for m=1:M*N
    row1=ceil(m/N);%遍历所有图像对的组合
    col1=m-N*(row1-1);
    for n=m:M*N
        row2=ceil(n/N);
        col2=n-N*(row2-1);
        s_1=(similarity(pic_h{row1,col1}(:,:,1),pic_h{row2,col2}(:,:,1))+...
            similarity(pic_h{row1,col1}(:,:,2),pic_h{row2,col2}(:,:,2))+...
            similarity(pic_h{row1,col1}(:,:,3),pic_h{row2,col2}(:,:,3)))/3;%计算相关系数
        s_c=similarity_a(co{row1,col1},co{row2,col2});
        sim_1(row1,col1,row2,col2)=s_1;%sim(picture1,picture2)=sim(picture2,picture1)
        sim_1(row2,col2,row1,col1)=s_1;%对称填充矩阵中两个位置
        sim_c(row1,col1,row2,col2)=s_c;
        sim_c(row2,col2,row1,col1)=s_c;
    end
end
sim_1=(sim_1-mean(sim_1,'all'))/sqrt(var(sim_1,1,'all'));%归一化
sim_c=(sim_c-mean(sim_c,'all'))/sqrt(var(sim_c,1,'all'));
sim=0.9*sim_1+0.1*sim_c;%两者加权叠加
save('../data/similarity_c.mat','sim');
%% 计算分类裕度
truth=load('../data/truth.mat').truth;
temp_max=-100;
temp_min=100;
for m=1:M*N
    row1=ceil(m/N);
    col1=m-N*(row1-1);
    for n=m:M*N
        row2=ceil(n/N);
        col2=n-N*(row2-1);
        if truth(row1,col1)==truth(row2,col2)
            s=sim(row1,col1,row2,col2);
            if s<temp_min
                temp_min=s;
            end
        else
            s=sim(row1,col1,row2,col2);
            if s>temp_max
                temp_max=s;
            end
        end
    end
end
margin=temp_min-temp_max;
%% 找出相关系数最大的10对方块
max_sim=zeros(10,1)-100;
max_pair=zeros(10,4);
for m=1:M*N
    row1=ceil(m/N);
    col1=m-N*(row1-1);
    for n=m:M*N
        row2=ceil(n/N);
        col2=n-N*(row2-1);
        if (row1~=row2|col1~=col2)&(sim(row1,col1,row2,col2)>min(max_sim))
            %维护数组，记录相关系数最大的10对图像
            [~,a]=min(max_sim);
            max_sim(a)=sim(row1,col1,row2,col2);
            max_pair(a,:)=[row1,col1,row2,col2];
        end
    end
end

figure;
for k=1:10%显示最大的10对图像
    subplot(2,10,k);
    imshow(pic{max_pair(k,1),max_pair(k,2)});
    title(num2str(sim(max_pair(k,1),max_pair(k,2),max_pair(k,3),max_pair(k,4))),'Fontsize',20);
    subplot(2,10,10+k);
    imshow(pic{max_pair(k,3),max_pair(k,4)});
end
%% 找出相关系数最大但不是相同方块的十对
max_sim_wrong=zeros(10,1)-100;
max_pair_wrong=zeros(10,4);
for m=1:M*N
    row1=ceil(m/N);
    col1=m-N*(row1-1);
    for n=m:M*N
        row2=ceil(n/N);
        col2=n-N*(row2-1);
        if truth(row1,col1)~=truth(row2,col2)&(sim(row1,col1,row2,col2)>min(max_sim_wrong))
            %维护数组，记录相关系数最大但不是同一种图像的10对
            [~,a]=min(max_sim_wrong);
            max_sim_wrong(a)=sim(row1,col1,row2,col2);
            max_pair_wrong(a,:)=[row1,col1,row2,col2];
        end
    end
end
figure;
for k=1:10%显示相关系数最大但不是同一种图像的10对
    subplot(2,10,k);
    imshow(pic{max_pair_wrong(k,1),max_pair_wrong(k,2)});
    title(num2str(sim(max_pair_wrong(k,1),max_pair_wrong(k,2),max_pair_wrong(k,3),max_pair_wrong(k,4))),'Fontsize',20);
    subplot(2,10,10+k);
    imshow(pic{max_pair_wrong(k,3),max_pair_wrong(k,4)});
end