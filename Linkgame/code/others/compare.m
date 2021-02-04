%比较顺序遍历与随机遍历用时长短
clear all;
close all;
clc;

mtx=generate(8,5,0.2,21);
 disp('down');
 
 time1=zeros(1,2000);
 for k=1:2000
     tic
     s=omg(mtx);
     toc
     time1(k)=toc;
 end
 
 time2=zeros(1,2000);
 for k=1:2000
     tic
     s=omg_1(mtx);
     toc
     time2(k)=toc;
 end
 
figure;
hold on;
scatter([1:2000],time2,'MarkerFaceColor','red','MarkerEdgeColor','none');
scatter([1:2000],time1,'MarkerFaceColor','blue','MarkerEdgeColor','none');
legend('随机遍历','顺序遍历');
xlabel('次数');
ylabel('用时（s）');