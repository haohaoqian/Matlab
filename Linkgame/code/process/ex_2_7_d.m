%2.7 模拟自动消去
clear all;
close all;
clc;

img=imread('colorcapture.jpg');%载入整体图片并显示
info=load('../data/info_c').info;%载入分割尺寸
l_margin=info(1);
t_margin=info(2);
width=info(3);
height=info(4);
imshow(img);
sim=load('../data/similarity_c').sim;%载入相似性数据
[M,N,~,~]=size(sim);
pause(1);%暂停显示图像
%% 模拟消去
mtx=zeros(M,N)+1;
while sum(sum(mtx))~=0%未完全消去时循环遍历
    max=0;%维护相关系数最大值
    max_pair=[0,0,0,0];
    for m=1:M*N
        row1=ceil(m/N);%遍历所有图像对的组合
        col1=m-N*(row1-1);
        if mtx(row1,col1)~=0
            for n=m+1:M*N
                row2=ceil(n/N);
                col2=n-N*(row2-1);
                if mtx(row2,col2)~=0
                    if (detect(mtx,row1,col1,row2,col2)==1)&(sim(row1,col1,row2,col2)>max)%寻找相关系数最大值
                        max=sim(row1,col1,row2,col2);
                        max_pair=[row1,col1,row2,col2];
                    end
                end
            end
        end
    end
    mtx(max_pair(1),max_pair(2))=0;%模拟消去方块
    mtx(max_pair(3),max_pair(4))=0;
    %绘制黑矩形模拟消去
    rectangle('position',[l_margin+1+(max_pair(2)-1)*width,t_margin+1+(max_pair(1)-1)*height,width,height],'LineWidth',1,'EdgeColor','none','FaceColor','black');
    rectangle('position',[l_margin+1+(max_pair(4)-1)*width,t_margin+1+(max_pair(3)-1)*height,width,height],'LineWidth',1,'EdgeColor','none','FaceColor','black');
    pause(0.5);
end