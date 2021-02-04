function steps = omg_1(mtx)
    % -------------- �������˵�� --------------
    
    %   ��������У�mtxΪͼ���ľ������������ĸ�ʽ��
    %   [ 1 2 3;
    %     0 2 1;
    %     3 0 0 ]
    %   ��ͬ�����ִ�����ͬ��ͼ����0����˴�û�п顣
    %   ������[m, n] = size(mtx)��ȡ������������
    
    %   ע��mtx��������Ϸ�����ͼ����λ�ö�Ӧ��ϵ���±�(x1, y1)��������������
    %   ������������½�Ϊԭ�㽨������ϵ��x�᷽���x1����y�᷽���y1��
    
    % --------------- �������˵�� --------------- %
    
    %   Ҫ�����ó��Ĳ����������steps������,��ʽ���£�
    %   steps(1)��ʾ��������
    %   ֮��ÿ�ĸ���x1 y1 x2 y2�������mtx(x1,y1)��mtx(x2,y2)��ʾ�Ŀ�������
    %   ʾ���� steps = [2, 1, 1, 1, 2, 2, 1, 3, 1];
    %   ��ʾһ������������һ����mtx(1,1)��mtx(1,2)��ʾ�Ŀ�������
    %   �ڶ�����mtx(2,1)��mtx(3,1)��ʾ�Ŀ�������
    
    %% --------------  �������������Ĵ��� O(��_��)O~  ------------
    
    [m, n] = size(mtx);
    temp=zeros(max(max(mtx)),2,m*n+1);%��ʱ���飬���淽�����
    temp(:,1,1)=1;%ÿҳ��һ�е�һ��Ԫ�ؼ�¼��ҳ��ǰĩβλ��
    steps=zeros(1,2*m*n+1);%steps��Ž��
    steps(1)=m*n/2;
    position=2;%����ָ���¼stepsĩβλ��
    for x=1:m
        for y=1:n
            if mtx(x,y)~=0
                temp(mtx(x,y),1,1)=temp(mtx(x,y),1,1)+1;%�ƶ�ĩβλ��
                temp(mtx(x,y),1,temp(mtx(x,y),1,1))=x;%���൱ǰ����
                temp(mtx(x,y),2,temp(mtx(x,y),1,1))=y;
            end
        end
    end
    while sum(sum(mtx))~=0%û����ȫ����ʱѭ��
        x=unidrnd(m);
        y=unidrnd(n);
        if mtx(x,y)~=0
            for k=2:temp(mtx(x,y),1,1)%������ͬ���ͷ���
                if (x~=temp(mtx(x,y),1,k)|y~=temp(mtx(x,y),2,k))&mtx(temp(mtx(x,y),1,k),temp(mtx(x,y),2,k))~=0&detect(mtx,x,y,temp(mtx(x,y),1,k),temp(mtx(x,y),2,k))
                    %�������δ��ȥ���ܹ���ȥ�ķ��飬���ҵ�һ�����ȥ�ķ����
                    steps(position:position+3)=[x,y,temp(mtx(x,y),1,k),temp(mtx(x,y),2,k)];%����������
                    position=position+4;%�ƶ�steps��ĩβָ��
                    mtx(temp(mtx(x,y),1,k),temp(mtx(x,y),2,k))=0;%mtx���Ѿ���ȥ�ķ�����Ϊ0
                    mtx(x,y)=0;
                    break;
                end
            end
        end
    end
end

