function steps = omg_1(mtx)
    % -------------- 输入参数说明 --------------
    
    %   输入参数中，mtx为图像块的矩阵，类似这样的格式：
    %   [ 1 2 3;
    %     0 2 1;
    %     3 0 0 ]
    %   相同的数字代表相同的图案，0代表此处没有块。
    %   可以用[m, n] = size(mtx)获取行数和列数。
    
    %   注意mtx矩阵与游戏区域的图像不是位置对应关系。下标(x1, y1)在连连看界面中
    %   代表的是以左下角为原点建立坐标系，x轴方向第x1个，y轴方向第y1个
    
    % --------------- 输出参数说明 --------------- %
    
    %   要求最后得出的操作步骤放在steps数组里,格式如下：
    %   steps(1)表示步骤数。
    %   之后每四个数x1 y1 x2 y2，代表把mtx(x1,y1)与mtx(x2,y2)表示的块相连。
    %   示例： steps = [2, 1, 1, 1, 2, 2, 1, 3, 1];
    %   表示一共有两步，第一步把mtx(1,1)和mtx(1,2)表示的块相连，
    %   第二步把mtx(2,1)和mtx(3,1)表示的块相连。
    
    %% --------------  请在下面加入你的代码 O(∩_∩)O~  ------------
    
    [m, n] = size(mtx);
    temp=zeros(max(max(mtx)),2,m*n+1);%临时数组，储存方块分类
    temp(:,1,1)=1;%每页第一行第一个元素记录该页当前末尾位置
    steps=zeros(1,2*m*n+1);%steps存放结果
    steps(1)=m*n/2;
    position=2;%辅助指针记录steps末尾位置
    for x=1:m
        for y=1:n
            if mtx(x,y)~=0
                temp(mtx(x,y),1,1)=temp(mtx(x,y),1,1)+1;%移动末尾位置
                temp(mtx(x,y),1,temp(mtx(x,y),1,1))=x;%归类当前方块
                temp(mtx(x,y),2,temp(mtx(x,y),1,1))=y;
            end
        end
    end
    while sum(sum(mtx))~=0%没有完全消除时循环
        x=unidrnd(m);
        y=unidrnd(n);
        if mtx(x,y)~=0
            for k=2:temp(mtx(x,y),1,1)%遍历相同类型方块
                if (x~=temp(mtx(x,y),1,k)|y~=temp(mtx(x,y),2,k))&mtx(temp(mtx(x,y),1,k),temp(mtx(x,y),2,k))~=0&detect(mtx,x,y,temp(mtx(x,y),1,k),temp(mtx(x,y),2,k))
                    %如果是尚未消去且能够消去的方块，则找到一组可消去的方块对
                    steps(position:position+3)=[x,y,temp(mtx(x,y),1,k),temp(mtx(x,y),2,k)];%插入结果数组
                    position=position+4;%移动steps的末尾指针
                    mtx(temp(mtx(x,y),1,k),temp(mtx(x,y),2,k))=0;%mtx中已经消去的方块置为0
                    mtx(x,y)=0;
                    break;
                end
            end
        end
    end
end

