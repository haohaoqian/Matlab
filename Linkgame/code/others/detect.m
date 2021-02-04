function bool = detect(mtx, x1, y1, x2, y2)
    % ========================== 参数说明 ==========================
    
    % 输入参数中，mtx为图像块的矩阵，类似这样的格式：
    % [ 1 2 3;
    %   0 2 1;
    %   3 0 0 ]
    % 相同的数字代表相同的图案，0代表此处没有块。
    % 可以用[m, n] = size(mtx)获取行数和列数。
    % (x1, y1)与（x2, y2）为需判断的两块的下标，即判断mtx(x1, y1)与mtx(x2, y2)
    % 是否可以消去。
    
    % 注意mtx矩阵与游戏区域的图像不是位置对应关系。下标(x1, y1)在连连看界面中
    % 代表的是以左下角为原点建立坐标系，x轴方向第x1个，y轴方向第y1个
    
    % 输出参数bool = 1表示可以消去，bool = 0表示不能消去。
    
    %% 在下面添加你的代码O(∩_∩)O
    
    [m, n] = size(mtx);
    bool=0;
    if mtx(x1,y1)==mtx(x2,y2)%判断两个方块是否相同
        bool=(sum(mtx(1:x1-1,y1))+sum(mtx(1:x2-1,y2))==0)|(sum(mtx(x1+1:m,y1))+sum(mtx(x2+1:m,y2))==0)...
            |(sum(mtx(x1,1:y1-1))+sum(mtx(x2,1:y2-1))==0)|(sum(mtx(x1,y1+1:n))+sum(mtx(x2,y2+1:n))==0);%如果两个方块都在边缘则可以消去
        if ~bool
            for k=2:m-1%横向循环，寻找可以通过两次弯折连接的通路
                if sum(mtx(x1:sgn(x1,k):k,y1))+sum(mtx(k,y1:sgn(y1,y2):y2))+sum(mtx(k:sgn(k,x2):x2,y2))-2*mtx(x1,y1)-mtx(k,y1)-mtx(k,y2)==0
                    bool=1;
                    break;
                end
            end
            if ~bool%如果前面没有找到连接通路，则继续寻找
                for k=2:n-1%纵向循环，寻找可以通过两次弯折连接的通路
                    if sum(mtx(x1,y1:sgn(y1,k):k))+sum(mtx(x1:sgn(x1,x2):x2,k))+sum(mtx(x2,k:sgn(k,y2):y2))-2*mtx(x1,y1)-mtx(x1,k)-mtx(x2,k)==0
                        bool=1;
                        break;
                    end
                end
            end
        end
    end     
end

function s=sgn(a,b)%自定义符号函数，便于进行矩阵索引
    if(a<=b)
        s=1;
    else
        s=-1;
    end
end  