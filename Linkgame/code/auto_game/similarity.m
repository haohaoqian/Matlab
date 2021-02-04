%% 相关系数函数
function s=similarity(mtx1,mtx2)
    mtx1=mtx1-mean(mean(mtx1));%除去直流分量
    mtx2=mtx2-mean(mean(mtx2));
    f_mtx1=fft2(mtx1);%傅里叶变换
    f_mtx2=fft2(mtx2);
    s_mtx=ifft2(f_mtx1.*conj(f_mtx2));%根据相关定理共轭相乘并傅里叶逆变换得到相关函数
    s_mtx=s_mtx/(sqrt(sum(sum(mtx1.*mtx1)))*sqrt(sum(sum(mtx2.*mtx2))));%相关函数归一化
    s=max(max(s_mtx));%最大值为相关系数
end