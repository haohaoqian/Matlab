function mark = color_judge(mtx,k)
%COLOR 由色彩判断是否为背景
%   输入：mtx 图像RGB矩阵
%   输出：mark 判断结果
%         n 1-8整数，二进制保留位数
    [M,N,~]=size(mtx);
    a=0;
    mark=1;
    sign=0;
    for m=1:M
        for n=1:N
            R=dec2bin(mtx(m,n,1),8);%转换为二进制并截取高n位
            G=dec2bin(mtx(m,n,2),8);
            B=dec2bin(mtx(m,n,3),8);
            temp=bin2dec([R(1:k),G(1:k),B(1:k)]);%连接并转为10进制
            if temp==0
                a=a+1;
            end
            if a>=0.6*M*N
                mark=0;
                sign=1;
                break;
            end 
        end
        if sign==1
            break;
        end
    end
end

