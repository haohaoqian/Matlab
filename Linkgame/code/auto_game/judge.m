function mark = judge(previous,row1,col1,row2,col2)
%JUDGE 判断当前方块对是否已经尝试消去过
mark=1;
[length,~]=size(previous);
if length~=0
    for k=1:length %遍历历史记录判断是否已经尝试消去过
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