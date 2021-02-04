%2.7 方块映射为索引值
clear all;
close all;
clc;

pic_s=load('pics.mat').pics;%载入标准图片
pic_t=load('../data/spilit_c.mat').spilit;%载入分割后的图片
info=load('../data/info_c.mat').info;%载入分割尺寸

pic_ht={};
h_c=(1+info(4))/2;%计算中心位置
w_c=(1+info(3))/2;
[M,N]=size(pic_t);
passband=2;%通带半径
for m=1:M
    for n=1:N
        temp0=im2double(pic_t{m,n});
        for ch=1:3
            temp=temp0(:,:,ch);%转化为double型
            temp=fftshift(fft2(temp));%傅里叶变换并将零频率移动到中心
            for x=1:floor(info(3)/2)
                x2=x^2;
                for y=1:floor(info(4)/2)
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
        pic_ht{m,n}=temp0;
    end
end

pic_hs={};
passband=2;
[height,width,~]=size(pic_s{1});
h_c=(1+height)/2;%计算中心位置
w_c=(1+width)/2;
figure;
for k=1:21
    %高通滤波得到标准图谱
    temp0=im2double(pic_s{k});
    for ch=1:3
        temp=temp0(:,:,ch);
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
	pic_hs{k}=temp0;
    pic_hs{k}=resize_a(pic_hs{k},info(4),info(3));
    subplot(1,21,k);
    imshow(pic_hs{k});
    title(['类型',num2str(k)],'Fontsize',12);
end

[M,N]=size(pic_t);
mtx=zeros(M,N)+1;
sim=zeros(M,N,21);
for m=1:M
    for n=1:N
        for k=2:21
            %遍历所有方块，匹配最相近的标准图谱，利用三通道匹配滤波
            if similarity(im2double(pic_ht{m,n}(:,:,1)),pic_hs{k}(:,:,1))+...
               similarity(im2double(pic_ht{m,n}(:,:,2)),pic_hs{k}(:,:,2))+...
               similarity(im2double(pic_ht{m,n}(:,:,3)),pic_hs{k}(:,:,3))>...
               similarity(im2double(pic_ht{m,n}(:,:,1)),pic_hs{mtx(m,n)}(:,:,1))+...
               similarity(im2double(pic_ht{m,n}(:,:,2)),pic_hs{mtx(m,n)}(:,:,2))+...
               similarity(im2double(pic_ht{m,n}(:,:,3)),pic_hs{mtx(m,n)}(:,:,3))
                mtx(m,n)=k;
            end
        end
    end
end