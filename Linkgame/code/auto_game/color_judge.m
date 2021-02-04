function mark = color_judge(mtx,k)
%COLOR ��ɫ���ж��Ƿ�Ϊ����
%   ���룺mtx ͼ��RGB����
%   �����mark �жϽ��
%         n 1-8�����������Ʊ���λ��
    [M,N,~]=size(mtx);
    a=0;
    mark=1;
    sign=0;
    for m=1:M
        for n=1:N
            R=dec2bin(mtx(m,n,1),8);%ת��Ϊ�����Ʋ���ȡ��nλ
            G=dec2bin(mtx(m,n,2),8);
            B=dec2bin(mtx(m,n,3),8);
            temp=bin2dec([R(1:k),G(1:k),B(1:k)]);%���Ӳ�תΪ10����
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

