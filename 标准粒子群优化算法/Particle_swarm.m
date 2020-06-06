% ��׼��Ⱥ�Ż��㷨����
%��⺯����Сֵ
close all
clear
clc
global popsize;     %��Ⱥ��ģ
%global popnum;      %��Ⱥ����
global pop;         %��Ⱥ
%global c0;          %�ٶȹ���ϵ��,Ϊ0��1�������
global c1;          %�������ŵ���ϵ��
global c2;          %ȫ�����ŵ���ϵ��
global gbest_x;       %ȫ�����Ž�x������
global gbest_y;       %ȫ�����Ž�y������
global best_fitness;    %���Ž�
global best_in_history; %���Ž�仯�켣
global x_min;           %x������
global x_max;           %x������
global y_min;           %y������
global y_max;           %y������
global gen;             %��������
global exetime;         %��ǰ��������
global max_velocity;    %����ٶ�
best_in_history=best_in_history(1:gen);
%�����ʼ��

gen=500;     %���õ�������������
popsize=20;     %������Ⱥ��ģ��С
best_in_history(gen)=inf;   %��ʼ��ȫ����ʷ���Ž�
best_in_history(:)=inf;   %��ʼ��ȫ����ʷ���Ž�
max_velocity=3;       %����ٶ�����                           �����Ҫ������
best_fitness=inf;
%popnum=1;       %������Ⱥ����

pop(popsize,8)=0;   %��ʼ����Ⱥ,����popsize��8�е�0����                             �޸���Ⱥά��
%��Ⱥ�����1��Ϊx�����꣬��2��Ϊy�����꣬��3��Ϊx���ٶȷ�������4��Ϊy���ٶȷ���
%��5��Ϊ��������λ�õ�x�����꣬��6��Ϊ��������λ�õ�y������
%��7��Ϊ����������ֵ����8��Ϊ��ǰ������Ӧֵ

for i=1:popsize
    pop(i,1)=200*rand()-100;     %��ʼ����Ⱥ�е�����λ�ã�ֵΪ-2��2������Ϊ���ٶ�
    pop(i,2)=200*rand()-100;     %��ʼ����Ⱥ�е�����λ�ã�ֵΪ-2��2������Ϊ���ٶ�
    pop(i,5)=pop(i,1);  %��ʼ״̬�¸�������ֵ���ڳ�ʼλ��
    pop(i,6)=pop(i,2);  %��ʼ״̬�¸�������ֵ���ڳ�ʼλ��
    pop(i,3)=rand()*6-3;    %��ʼ����Ⱥ΢���ٶȣ�ֵΪ-0.01��0.01�����Ϊ0.0001
    pop(i,4)=rand()*6-3;    %��ʼ����Ⱥ΢���ٶȣ�ֵΪ-0.01��0.01�����Ϊ0.0001
    pop(i,7)=inf;
    pop(i,8)=inf;
end

c1=2;
c2=2;
x_min=-100;
y_min=-100;
x_max=100;
y_max=100;


w=0.9; % Ȩ������                                           �����Ҫ�����������
gbest_x=pop(1,1);   %ȫ�����ų�ʼֵΪ��Ⱥ��һ�����ӵ�λ��
gbest_y=pop(1,2);


% initial;        %��ʼ��
for exetime=1:gen
history(exetime,:)=[gbest_x gbest_y];
    adapting;       %������Ӧֵ
    updatepop;      %��������λ��
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















