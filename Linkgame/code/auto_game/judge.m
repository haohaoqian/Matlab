function mark = judge(previous,row1,col1,row2,col2)
%JUDGE �жϵ�ǰ������Ƿ��Ѿ�������ȥ��
mark=1;
[length,~]=size(previous);
if length~=0
    for k=1:length %������ʷ��¼�ж��Ƿ��Ѿ�������ȥ��
        if row1==previous(k,1)&row2==previous(k,3)&col1==previous(k,2)&col2==previous(k,4)
            mark=0;
            break;
        elseif row2==previous(k,1)&row1==previous(k,3)&col2==previous(k,2)&col1==previous(k,4)
            mark=0;
            break;
        end
    end
end
end