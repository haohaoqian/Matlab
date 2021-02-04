function bool = detect(mtx, x1, y1, x2, y2)
    % ========================== ����˵�� ==========================
    
    % ��������У�mtxΪͼ���ľ������������ĸ�ʽ��
    % [ 1 2 3;
    %   0 2 1;
    %   3 0 0 ]
    % ��ͬ�����ִ�����ͬ��ͼ����0����˴�û�п顣
    % ������[m, n] = size(mtx)��ȡ������������
    % (x1, y1)�루x2, y2��Ϊ���жϵ�������±꣬���ж�mtx(x1, y1)��mtx(x2, y2)
    % �Ƿ������ȥ��
    
    % ע��mtx��������Ϸ�����ͼ����λ�ö�Ӧ��ϵ���±�(x1, y1)��������������
    % ������������½�Ϊԭ�㽨������ϵ��x�᷽���x1����y�᷽���y1��
    
    % �������bool = 1��ʾ������ȥ��bool = 0��ʾ������ȥ��
    
    %% �����������Ĵ���O(��_��)O
    
    [m, n] = size(mtx);
    bool=0;
    if mtx(x1,y1)==mtx(x2,y2)%�ж����������Ƿ���ͬ
        bool=(sum(mtx(1:x1-1,y1))+sum(mtx(1:x2-1,y2))==0)|(sum(mtx(x1+1:m,y1))+sum(mtx(x2+1:m,y2))==0)...
            |(sum(mtx(x1,1:y1-1))+sum(mtx(x2,1:y2-1))==0)|(sum(mtx(x1,y1+1:n))+sum(mtx(x2,y2+1:n))==0);%����������鶼�ڱ�Ե�������ȥ
        if ~bool
            for k=2:m-1%����ѭ����Ѱ�ҿ���ͨ�������������ӵ�ͨ·
                if sum(mtx(x1:sgn(x1,k):k,y1))+sum(mtx(k,y1:sgn(y1,y2):y2))+sum(mtx(k:sgn(k,x2):x2,y2))-2*mtx(x1,y1)-mtx(k,y1)-mtx(k,y2)==0
                    bool=1;
                    break;
                end
            end
            if ~bool%���ǰ��û���ҵ�����ͨ·�������Ѱ��
                for k=2:n-1%����ѭ����Ѱ�ҿ���ͨ�������������ӵ�ͨ·
                    if sum(mtx(x1,y1:sgn(y1,k):k))+sum(mtx(x1:sgn(x1,x2):x2,k))+sum(mtx(x2,k:sgn(k,y2):y2))-2*mtx(x1,y1)-mtx(x1,k)-mtx(x2,k)==0
                        bool=1;
                        break;
                    end
                end
            end
        end
    end     
end

function s=sgn(a,b)%�Զ�����ź��������ڽ��о�������
    if(a<=b)
        s=1;
    else
        s=-1;
    end
end  