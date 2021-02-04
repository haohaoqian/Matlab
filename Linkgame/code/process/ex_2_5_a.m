%2.5 方法一：无监督分类——确定相同方块对之间相关系数的最小值
clear all;
close all;
clc;

sim=load('../data/similarity.mat').sim;
truth=load('../data/truth.mat').truth;
[M,N,~,~]=size(sim);
min_sim=100;
min_pair=zeros(4);
for m=1:M*N
    row1=ceil(m/N);
    col1=m-N*(row1-1);
    for n=m:M*N
        row2=ceil(n/N);
        col2=n-N*(row2-1);
        if truth(row1,col1)==truth(row2,col2)&(sim(row1,col1,row2,col2)<min_sim)
            %维护数组，记录相关系数最小但不的同一种图像的10对
            min_sim=sim(row1,col1,row2,col2);
            min_pair=[row1,col1,row2,col2];
        end
    end
end
pics=load('../data/spilit.mat').spilit;
figure;%显示相关系数最小的一对同种方块
subplot(1,2,1);
imshow(pics{min_pair(1),min_pair(2)});
subplot(1,2,2);
imshow(pics{min_pair(3),min_pair(4)});