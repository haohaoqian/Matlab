%2.3 2.4 计算方块相似性
clear all;
close all;
clc;

pic=load('../data/spilit.mat');
[M,N]=size(pic.spilit);
[height,width]=size(pic.spilit{1,1});
%% 高通滤波
pic_h={};
h_c=(1+height)/2;%计算中心位置
w_c=(1+width)/2;
passband=2;%通带半径
for m=1:M
    for n=1:N
        temp=im2double(pic.spilit{m,n});%转化为double型
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
        pic_h{m,n}=temp;
    end
end
%% 计算相关系数
sim=zeros(M,N,M,N);
for m=1:M*N
    row1=ceil(m/N);%遍历所有图像对的组合
    col1=m-N*(row1-1);
    for n=m:M*N
        row2=ceil(n/N);
        col2=n-N*(row2-1);
        s=similarity(pic_h{row1,col1},pic_h{row2,col2});%计算相关系数
        sim(row1,col1,row2,col2)=s;%sim(picture1,picture2)=sim(picture2,picture1)
        sim(row2,col2,row1,col1)=s;%对称填充矩阵中两个位置
    end
end
sim=(sim-mean(sim,'all'))/sqrt(var(sim,1,'all'));%归一化
save('../data/similarity.mat','sim');
%% 计算分类裕度
truth=load('../data/truth.mat').truth;
% figure;
% hold on;
% box on;
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
            %scatter(m*n,s,'MarkerFaceColor','g','MarkerEdgeColor','none');
            %取消注释可以绘制散点图，绘图耗时较长
            if s<temp_min
                temp_min=s;
            end
        else
            s=sim(row1,col1,row2,col2);
            %scatter(m*n,s,'MarkerFaceColor','r','MarkerEdgeColor','none');
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
    imshow(pic.spilit{max_pair(k,1),max_pair(k,2)});
    title(num2str(sim(max_pair(k,1),max_pair(k,2),max_pair(k,3),max_pair(k,4))),'Fontsize',20);
    subplot(2,10,10+k);
    imshow(pic.spilit{max_pair(k,3),max_pair(k,4)});
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
    imshow(pic.spilit{max_pair_wrong(k,1),max_pair_wrong(k,2)});
    title(num2str(sim(max_pair_wrong(k,1),max_pair_wrong(k,2),max_pair_wrong(k,3),max_pair_wrong(k,4))),'Fontsize',20);
    subplot(2,10,10+k);
    imshow(pic.spilit{max_pair_wrong(k,3),max_pair_wrong(k,4)});
end