function output = locatepeak(X,Y,thY,thX)
%��λ��ֵ
if length(X)~=length(Y)
    disp('The length of omg and F does not match!')%��������Ƿ�ƥ��
else
    output=[];
    for m=1:length(X)
        p=m;q=m;%���Ҹ���ָ��ȷ���ֲ���ֵ�ķ�Χ
        while X(m)-X(p)<=thX%ȷ����ָ��λ��
            if p==1
                break;
            end
            p=p-1;
        end
        while X(q)-X(m)<=thX%ȷ����ָ��λ��
            if q==length(X)
                break;
            end
            q=q+1;
        end
        if Y(m)==max(Y(p:q))&Y(m)>=thY%�Ǿֲ���ֵ��ȷ��Ϊ��ֵ
            output=[output;X(m),Y(m)];
        end
    end
end
end

