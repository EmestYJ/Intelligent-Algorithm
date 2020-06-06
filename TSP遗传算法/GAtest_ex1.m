clear all
clc
%***********1个体的编码、2产生初始种群、3计算适应值*******

N=20;
%产生随机数
for i=1:N
    for j=1:33
        if rand<=0.5
                p(i,j)=0;  
        else
                p(i,j)=1;
        end
    end
    %p(x,j)
x1=bin2dec(num2str(p(i,1:18)))*(12.1+3)/(2^18-1)+(-3);
x2=bin2dec(num2str(p(i,19:33)))*(5.8-4.1)/(2^15-1)+(4.1);
y(i)=f(x1,x2);

end
%***************4父体选择*****************

for diedai=1:660

%计算种群中所有染色体适应值之和
F=0;
for i=1:N
    F=F+y(i);
end

for k=2:(N+1)
     T(1)=0;
    %计算每个染色体的选择概率
    P(k-1)=y(k-1)/F;
    %计算每个染色体的累计概率
    T(k)=T(k-1)+P(k-1);
    q(k-1)=T(k);
end

%轮盘转动N次，从中选出N个染色体，编号为n(1-20)
for i=1:N
    r=rand;
    
    j=1;
    while (r>q(j)) 
        j=j+1 ;
    end
    max(j);
    m(i)=max(j)-1;
end
%将m(i)中的0置为1，其余不变
for i=1:N
    if (m(i)==0)
        m(i)=1;
    end
    n(i)=m(i);
end 
%***********5杂交***********

%找出要进行杂交的父体
pc=0.25;
a=[];
for i=1:N
    R(i)=rand;
    while(R(i)<pc)
        A=[a,i];                    %把结果i存入数组A中
        a=A;
        break
    end
end
%a(1)
[mm,nn]=size(a);             %生成与矩阵a大小相同的数组
zaj_length=nn;               %数组a的列数

%确定进行杂交的染色体数
if mod(zaj_length,2)==0
    zaj_num=zaj_length;
else
    zaj_num=zaj_length-1;
end


b=[];
for i=1:(zaj_num)
    b(i)=a(i);
   
end


for i=1:(zaj_num/2)
            %随机的生成[1,32]中的一个整数pos
    pos=randi([1,32],1,1);   %生成的（M,N)即(1,1) 矩阵的随机二进制数字,
                                  %“ 0 ”和“ 1 ”出现的概率均等
    p(b(2*i-1),:)= [p(b(2*i-1),1:(pos)),p(b(2*i),(pos+1):33)];
    p(b(2*i),:)= [p(b(2*i),1:(pos)),p(b(2*i-1),(pos+1):33)];
end


%********6变异******
%pos=randint(1,1,[1,660]);
pm=0.01;
h=[];
for i=1:660
    RM(i)=rand;
    while(RM(i)<pm)
        H=[h,i];   %发生变异，把结果i存入数组H中
        h=H;
        break
    end
end

[hm,hn]=size(h);
hnm=hn;         %需变异的基因的位置个数，数组h的列数
for i=2:hnm-1
    if(mod(h(i),33)==0)
        
        if(p(floor(h(i)/33)+1, mod(h(i),33)+1)==0)
            p(floor(h(i)/33)+1, mod(h(i),33)+1)=1;
        else
            p(floor(h(i)/33)+1, mod(h(i),33)+1)=0;
        end
    else
        if(p(floor(h(i)/33)+1, mod(h(i),33))==0)
            p(floor(h(i)/33)+1, mod(h(i),33))=1;
        else
            p(floor(h(i)/33)+1, mod(h(i),33))=0;
        end
    end
end
            
x1=bin2dec(num2str(p(i,1:18)))*(12.1+3)/(2^18-1)+(-3);
x2=bin2dec(num2str(p(i,19:33)))*(5.8-4.1)/(2^15-1)+(4.1);
y(i)=f(x1,x2)

end     


 