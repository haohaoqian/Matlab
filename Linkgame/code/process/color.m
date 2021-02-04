function v = color(mtx,k)
%COLOR 计算图像色彩直方图
%   输入：mtx 图像RGB矩阵
%   输出：v 色彩直方向量
%         n 1-8整数，二进制保留位数
    [M,N,~]=size(mtx);
    v=zeros(1,power(2,3*k));
    for m=1:M
        for n=1:N
            R=dec2bin(mtx(m,n,1),8);%转换为二进制并截取高n位
            G=dec2bin(mtx(m,n,2),8);
            B=dec2bin(mtx(m,n,3),8);
            temp=bin2dec([R(1:k),G(1:k),B(1:k)])+1;%连接并转为10进制
            v(temp)=v(temp)+1;
        end
    end
end

