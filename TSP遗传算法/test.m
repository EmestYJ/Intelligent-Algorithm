%GA_TSP基于遗传算法的旅行商问题

clear
clc
close all
X=[16.47,96.10
   16.47,94.44
   20.09,92.54
   22.39,93.37
   25.23,97.24
   22.00,96.05
   20.47,97.02
   17.20,96.29
   16.30,97.38
   14.05,98.12
   16.53,97.38
   21.52,95.59
   19.41,97.13
   20.09,92.55
   14.32,97.11
   14.84,96.45
   15.23,95.66
   15.79,95.11
   16.55,95.33
   17.21,94.12
   18.01,95.33
   19.53,96.99
   21.36,93.55
   25.22,94.33
   23.44,95.66
   24.56,96.36
   23.45,97.88
   25.66,95.36
   23.55,98.78
   19.55,99.88];    %个城市的坐标位置
NIND=100;           %种群规模大小
MAXGEN=500;         %迭代次数
Pc=0.9;             %交叉概率
Pm=0.2;             %变异概率
GGAP=0.9;           %代沟（generation gap)
D=Distanse(X);      %生成距离矩阵
N=size(D,1);        %城市个数，现（20*20），（34*34），
%%初始化种群
Chrom=InitPop(NIND,N);
%%在二维图上绘制出所有的坐标点
%figure
%plot(X(:,1),X(:,2),'o');
%%绘制出随机解的路线图
DrawPath(Chrom(1,:),X)
pause(0.0001)
%%输出随机解的路线和总距离
disp('初始种群中的一个随机值：')
OutputPath(Chrom(1,:));
Rlength=PathLength(D,Chrom(1,:));   %Rlength为路径长度
disp(['总距离：',num2str(Rlength)]);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
%%优化
gen=0;
figure;
hold on;
box on
xlim([0,MAXGEN])                      %绘制优化迭代图
title('优化过程')
xlabel('代数')
ylabel('最优值')                       %路线长度
ObjV=PathLength(D,Chrom);                %计算路线长度
preObjV=min(ObjV);
while gen<MAXGEN
    %%计算适应度
    ObjV=PathLength(D,Chrom);           %计算路线长度
    %fprintf('%d   %1.10f\n',gen,min(ObjV))
   line([gen-1,gen],[preObjV,min(ObjV)]);pause(0.0001)
   preObjV=min(ObjV);
   FitnV=Fitness(ObjV);
   %%选择
   SelCh=Select(Chrom,FitnV,GGAP);
   %%交叉操作
   SelCh=Recombin(SelCh,Pc);
   %%变异
   SelCh=Mutate(SelCh,Pm);
   %%逆转操作
   SelCh=Reverse(SelCh,D);
   %%重插入子代的新种群
   Chrom=Reins(Chrom,SelCh,ObjV);
   %%更新迭代次数
   gen=gen+1;
end
%%绘制出最优解的路线图
ObjV=PathLength(D,Chrom);%计算路线长度
[minObjV,minInd]=min(ObjV);
DrawPath(Chrom(minInd(1),:),X)
%%输出最优解的路线和总距离
disp('最优解：')
p=OutputPath(Chrom(minInd(1),:));
disp(['总距离：',num2str(ObjV(minInd(1)))]);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

          
