%% 相关一维向量系数函数
function s=similarity_a(vec1,vec2)
    vec1=vec1-mean(vec1);%除去直流分量
    vec2=vec2-mean(vec2);
    f_vec1=fft(vec1);%傅里叶变换
    f_vec2=fft(vec2);
    s_vec=ifft2(f_vec1.*conj(f_vec2));%根据相关定理共轭相乘并傅里叶逆变换得到相关函数
    s_vec=s_vec/(sqrt(sum(vec1.*vec1))*sqrt(sum(vec2.*vec2)));%相关函数归一化
    s=max(s_vec);%最大值为相关系数
end