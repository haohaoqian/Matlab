function output = locatepeak(X,Y,thY,thX)
%定位峰值
if length(X)~=length(Y)
    disp('The length of omg and F does not match!')%检查输入是否匹配
else
    output=[];
    for m=1:length(X)
        p=m;q=m;%左右辅助指针确定局部极值的范围
        while X(m)-X(p)<=thX%确定左指针位置
            if p==1
                break;
            end
            p=p-1;
        end
        while X(q)-X(m)<=thX%确定右指针位置
            if q==length(X)
                break;
            end
            q=q+1;
        end
        if Y(m)==max(Y(p:q))&Y(m)>=thY%是局部极值则确定为峰值
            output=[output;X(m),Y(m)];
        end
    end
end
end

