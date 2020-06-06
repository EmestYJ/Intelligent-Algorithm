% 标准粒群优化算法程序
%求解函数最小值
close all
clear
clc
global popsize;     %种群规模
%global popnum;      %种群数量
global pop;         %种群
%global c0;          %速度惯性系数,为0—1的随机数
global c1;          %个体最优导向系数
global c2;          %全局最优导向系数
global gbest_x;       %全局最优解x轴坐标
global gbest_y;       %全局最优解y轴坐标
global best_fitness;    %最优解
global best_in_history; %最优解变化轨迹
global x_min;           %x的下限
global x_max;           %x的上限
global y_min;           %y的下限
global y_max;           %y的上限
global gen;             %迭代次数
global exetime;         %当前迭代次数
global max_velocity;    %最大速度
best_in_history=best_in_history(1:gen);
%程序初始化

gen=500;     %设置迭代次数！！！
popsize=20;     %设置种群规模大小
best_in_history(gen)=inf;   %初始化全局历史最优解
best_in_history(:)=inf;   %初始化全局历史最优解
max_velocity=3;       %最大速度限制                           这个需要更新下
best_fitness=inf;
%popnum=1;       %设置种群数量

pop(popsize,8)=0;   %初始化种群,创建popsize行8列的0矩阵                             修改种群维数
%种群数组第1列为x轴坐标，第2列为y轴坐标，第3列为x轴速度分量，第4列为y轴速度分量
%第5列为个体最优位置的x轴坐标，第6列为个体最优位置的y轴坐标
%第7列为个体最优适值，第8列为当前个体适应值

for i=1:popsize
    pop(i,1)=200*rand()-100;     %初始化种群中的粒子位置，值为-2—2，步长为其速度
    pop(i,2)=200*rand()-100;     %初始化种群中的粒子位置，值为-2—2，步长为其速度
    pop(i,5)=pop(i,1);  %初始状态下个体最优值等于初始位置
    pop(i,6)=pop(i,2);  %初始状态下个体最优值等于初始位置
    pop(i,3)=rand()*6-3;    %初始化种群微粒速度，值为-0.01—0.01，间隔为0.0001
    pop(i,4)=rand()*6-3;    %初始化种群微粒速度，值为-0.01—0.01，间隔为0.0001
    pop(i,7)=inf;
    pop(i,8)=inf;
end

c1=2;
c2=2;
x_min=-100;
y_min=-100;
x_max=100;
y_max=100;


w=0.9; % 权重因子                                           这个需要调整看看结果
gbest_x=pop(1,1);   %全局最优初始值为种群第一个粒子的位置
gbest_y=pop(1,2);


% initial;        %初始化
for exetime=1:gen
history(exetime,:)=[gbest_x gbest_y];
    adapting;       %计算适应值
    updatepop;      %更新粒子位置
end

figure
subplot(2,1,1)
plot(1:gen,history(:,1),'-')
legend({'x1'})
title(['best\_x1=' num2str(gbest_x)])
subplot(2,1,2)
plot(1:gen,history(:,2),'--')
legend({'x2'})
title([ 'best\_x2=' num2str(gbest_y)])

figure
plot(1:gen,best_in_history,'-')
legend({'f(x,y)'})
title(['best\_f(x1,x2)=' num2str(best_in_history(end))])















