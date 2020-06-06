%适值计算

%计算适应值并赋值
for i=1:popsize
    pop(i,8)=0.5+(sin(sqrt(pop(i,1)^2+pop(i,2)^2))^2-0.5)/((1+0.001*(pop(i,1)^2+pop(i,2)^2))^2);
    if pop(i,7)>pop(i,8)    %若当前适应值优于个体最优值，则进行个体最优信息的更新
        pop(i,7)=pop(i,8);          %适值更新
        pop(i,5:6)=pop(i,1:2);      %位置坐标更新
    end
end

%计算完适应值后寻找当前全局最优位置并记录其坐标
if best_fitness>min(pop(:,7))
    best_fitness=min(pop(:,7));     %全局最优值
    gbest_x=pop(find(pop(:,7)==min(pop(:,7))),1);    %全局最优粒子的位置   
    gbest_y=pop(find(pop(:,7)==min(pop(:,7))),2);
end

best_in_history(exetime)=best_fitness;  %记录当前全局最优