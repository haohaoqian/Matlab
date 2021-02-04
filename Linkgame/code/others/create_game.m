%1.4 生成游戏区域
clear all;
close all;
clc;

L=12;%区域长度
H=7;%区域高度
p=0.4;%紧邻方块比例
N=21;%方块种类数目

tic;
game=generate(L,H,p,N);
toc;

pictures=load('pics.mat');
[m,n,q] = size(pictures.a);
gamepic=zeros(H*m,L*n,q,'uint8');
for k1=1:H
    for k2=1:L
        gamepic((k1-1)*m+1:k1*m,(k2-1)*n+1:k2*n,:)=pictures.pics{game(k2,k1)};
    end
end
imshow(gamepic);