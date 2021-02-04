%2.5 方法一：无监督分类——方块映射为索引值
clear all;
close all;
clc;

thre=1.7;%阈值
sim=load('../data/similarity.mat').sim;
pics=load('../data/spilit.mat').spilit;
[M,N,~,~]=size(sim);
class_count=0;%类别总数
class_num_max=0;%一类中最多方块数
mtx=zeros(M,N);%索引数组
for m=1:M*N
    row1=ceil(m/N);
    col1=m-N*(row1-1);
    if mtx(row1,col1)~=0%如果方块已经被归类则跳过该方块
        continue;
    else
        count=0;%该类别方块数目
        class_count=class_count+1;
        for n=m:M*N
            row2=ceil(n/N);
            col2=n-N*(row2-1);
            if sim(row1,col1,row2,col2)>thre%大于阈值则归为同一类
                count=count+1;
                mtx(row2,col2)=class_count;
            end
        end
        if count>class_num_max
            class_num_max=count;
        end
    end
end
%按照mtx中索引分类
cluster=zeros(class_count,class_num_max*2+1);
for m=1:M
    for n=1:N
        cluster(mtx(m,n),1)=cluster(mtx(m,n),1)+1;
        cluster(mtx(m,n),cluster(mtx(m,n),1)*2)=m;
        cluster(mtx(m,n),cluster(mtx(m,n),1)*2+1)=n;
    end
end
%按类别画出所有方块
figure
for m=1:class_count
    for n=1:class_num_max
        if cluster(m,n*2)~=0
            subplot(class_num_max,class_count,m+(n-1)*class_count);
            imshow(pics{cluster(m,n*2),cluster(m,n*2+1)});
        end
    end
    subplot(class_num_max,class_count,m);
    title(['类型',num2str(m)],'Fontsize',12);
end