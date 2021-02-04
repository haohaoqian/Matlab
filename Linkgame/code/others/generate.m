%随机生成给定尺寸的游戏区域
function mtx=generate(L,H,p,N)
% 输入参数
% L：游戏区域长
% H：游戏区域宽
% p：紧邻方块对的比例
% N：方块种类数目
% 输出参数
% mtx：L*H的矩阵
    if(mod(L*H,2)~=0)%判断给出尺寸的合理性
        disp('error：区域尺寸不合法！');
    else
        mtx_temp=zeros(L,H);
        pairs_temp=zeros(int8(L*H*p*0.5),4);
        position_temp=1;
        for k=1:int8(L*H*p*0.5)%首先确定紧邻的方块对位置
            while true
                x=unidrnd(L);%随机生成坐标
                y=unidrnd(H);
                a=unidrnd(2);
                if a==1
                    x1=x+1;%随机数a为1则左右相邻
                    y1=y;
                else
                    x1=x;%随机数a为1则上下相邻
                    y1=y+1;
                end
                if x1<=L & y1<=H & mtx_temp(x,y)==0 & mtx_temp(x1,y1)==0%生成的随机数合法且不与已有方块冲突则加入记录中
                    mtx_temp(x,y)=1;
                    mtx_temp(x1,y1)=1;
                    pairs_temp(position_temp,:)=[x,y,x1,y1];
                    position_temp=position_temp+1;
                    break;
                end
            end
        end
        while true
            mtx=zeros(L,H);
            pairs=zeros(L*H*0.5,4);
            pairs(1:int8(L*H*p*0.5),:)=pairs_temp;
            position=position_temp;
            while position<=L*H*0.5%生成非紧邻的方块对
                count=0;
                flag=0;
                while true
                    x=unidrnd(L);%随机生成两个方块的坐标
                    y=unidrnd(H);
                    x1=unidrnd(L);
                    y1=unidrnd(H);
                    if (x~=x1|y~=y1) & mtx(x,y)==0 & mtx(x1,y1)==0 & mtx_temp(x,y)==0 & mtx_temp(x1,y1)==0
                        %判断生成的两个方块不是相同位置且不与已有方块冲突
                        mtx(x,y)=1;
                        mtx(x1,y1)=1;
                        if detect(mtx,x,y,x1,y1)
                            %判断生成的两个方块是否可以弯折两次以内相连
                            pairs(position,:)=[x,y,x1,y1];
                            position=position+1;
                            break;
                        else
                            mtx(x,y)=0;
                            mtx(x1,y1)=0;
                        end
                    end
                    count=count+1;
                    if count>=10000
                        %如果多次随机生成不符合条件，则重新随机生成整个区域
                        flag=1;
                        break;
                    end
                end
                if flag==1
                    break;
                end
            end
            if position==L*H*0.5+1 & flag==0
                %全部区域中已经两两配对，生成结束
                break;
            end
        end
        for k=1:L*H*0.5
            %随机生成方块种类，填充已经配好的方块对
            type=unidrnd(N);
            mtx(pairs(k,1),pairs(k,2))=type;
            mtx(pairs(k,3),pairs(k,4))=type;
        end
    end
end