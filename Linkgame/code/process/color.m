function v = color(mtx,k)
%COLOR ����ͼ��ɫ��ֱ��ͼ
%   ���룺mtx ͼ��RGB����
%   �����v ɫ��ֱ������
%         n 1-8�����������Ʊ���λ��
    [M,N,~]=size(mtx);
    v=zeros(1,power(2,3*k));
    for m=1:M
        for n=1:N
            R=dec2bin(mtx(m,n,1),8);%ת��Ϊ�����Ʋ���ȡ��nλ
            G=dec2bin(mtx(m,n,2),8);
            B=dec2bin(mtx(m,n,3),8);
            temp=bin2dec([R(1:k),G(1:k),B(1:k)])+1;%���Ӳ�תΪ10����
            v(temp)=v(temp)+1;
        end
    end
end

