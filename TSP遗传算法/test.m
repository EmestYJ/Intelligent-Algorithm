%GA_TSP�����Ŵ��㷨������������

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
   19.55,99.88];    %�����е�����λ��
NIND=100;           %��Ⱥ��ģ��С
MAXGEN=500;         %��������
Pc=0.9;             %�������
Pm=0.2;             %�������
GGAP=0.9;           %������generation gap)
D=Distanse(X);      %���ɾ������
N=size(D,1);        %���и������֣�20*20������34*34����
%%��ʼ����Ⱥ
Chrom=InitPop(NIND,N);
%%�ڶ�άͼ�ϻ��Ƴ����е������
%figure
%plot(X(:,1),X(:,2),'o');
%%���Ƴ�������·��ͼ
DrawPath(Chrom(1,:),X)
pause(0.0001)
%%���������·�ߺ��ܾ���
disp('��ʼ��Ⱥ�е�һ�����ֵ��')
OutputPath(Chrom(1,:));
Rlength=PathLength(D,Chrom(1,:));   %RlengthΪ·������
disp(['�ܾ��룺',num2str(Rlength)]);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
%%�Ż�
gen=0;
figure;
hold on;
box on
xlim([0,MAXGEN])                      %�����Ż�����ͼ
title('�Ż�����')
xlabel('����')
ylabel('����ֵ')                       %·�߳���
ObjV=PathLength(D,Chrom);                %����·�߳���
preObjV=min(ObjV);
while gen<MAXGEN
    %%������Ӧ��
    ObjV=PathLength(D,Chrom);           %����·�߳���
    %fprintf('%d   %1.10f\n',gen,min(ObjV))
   line([gen-1,gen],[preObjV,min(ObjV)]);pause(0.0001)
   preObjV=min(ObjV);
   FitnV=Fitness(ObjV);
   %%ѡ��
   SelCh=Select(Chrom,FitnV,GGAP);
   %%�������
   SelCh=Recombin(SelCh,Pc);
   %%����
   SelCh=Mutate(SelCh,Pm);
   %%��ת����
   SelCh=Reverse(SelCh,D);
   %%�ز����Ӵ�������Ⱥ
   Chrom=Reins(Chrom,SelCh,ObjV);
   %%���µ�������
   gen=gen+1;
end
%%���Ƴ����Ž��·��ͼ
ObjV=PathLength(D,Chrom);%����·�߳���
[minObjV,minInd]=min(ObjV);
DrawPath(Chrom(minInd(1),:),X)
%%������Ž��·�ߺ��ܾ���
disp('���Ž⣺')
p=OutputPath(Chrom(minInd(1),:));
disp(['�ܾ��룺',num2str(ObjV(minInd(1)))]);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')

          
