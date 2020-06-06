%%��ջ�������
clear all
clc
%%������м���໥����
 citys=[4.0905   15.4982
   17.1478    6.9019
   18.4778   16.8426
   12.7940   17.4721];                              %�����е�����λ��14*2
%citynums=4;
% for i=1:citynums
%     citys(i,:)=20*rand(1,2)
% end
 n=size(citys,1) ;  %����citys������
 D=zeros(n,n);
 for i=1:n
     for j=1:n
         if i~=j
             D(i,j)=sqrt(((citys(i,1)-citys(j,1))^2+(citys(i,2)-citys(j,2))^2));
         else
             D(i,j)=1e-4;
         end
     end
 end


%%������4������Ϊ��
%D=[1e-4,12,17,6;12,1e-4,3,4;17,3,1e-4,18;6,4,18,1e-4];
dirh=D;
n=size(D,1);

%%��ʼ������
m=20;	%��������
alpha=1;	%��Ϣ����Ҫ�̶�����
beta=5;		%����������Ҫ�̶�����
rho=0.1;	%��Ϣ�ػӷ�����
Q=1;		%��ϵ��
Eta=1./D;	%��������
Tau=ones(n,n);	%��Ϣ�ؾ���
Table=zeros(m,n);	%·����¼��	
iter=1;		%����������ֵ
iter_max=300;	%����������
Route_best=zeros(iter_max,n);	%�������·��
Length_best=zeros(iter_max,1);	%�������·���ĳ���
Length_ave=zeros(iter_max,1);	%����·����ƽ������


%%����Ѱ������·��
%%����tabu�д洢�����Ѿ����ʹ��ĳ��б�ż���
%%����allow�洢���Ǵ����ʵĳ��б�ż���
while iter<=iter_max
    %��������������ϵ�������
    start=zeros(m,1);
    for i=1:m
        temp=randperm(n);
        start(i)=temp(1);
    end
    Table(:,1)=start;
    %������ռ�
    citys_index=1:n;
    %�������·��ѡ��
    for i=1:m
        %�������·��ѡ��
        for j=2:n
            tabu=Table(i,1:(j-1));  %�ѷ��ʵĳ��м���
            allow_index=~ismember(citys_index,tabu);   %ismember�ж�citys_index�е�Ԫ����û����tabu�г���
            allow=citys_index(allow_index);    %�����ʵĳ��м���
            P=allow;
            %������м�ת�Ƹ���
            for k=1:length(allow)       %length���allow��ά��
 
           P(k)=Tau(tabu(end),allow(k))^alpha*Eta(tabu(end),allow(k))^beta;
            
            end
              P=P/sum(P);
            %���̶ķ�ѡ����һ������
            Pc=cumsum(P);   %cumsum�����������Ԫ�ص��ۼӺ�
            target_index=find(Pc>=rand);
            target=allow(target_index(1));
            Table(i,j)=target;
        end
    end
    
    %����������ϵ�·������
    Length=zeros(m,1);
    for i=1:m
        Route=Table(i,:);
        for j=1:(n-1)
            Length(i)=Length(i)+D(Route(j),Route(j+1));
        end
        Length(i)=Length(i)+D(Route(n),Route(1));
    end
    
    %�������·�����뼰ƽ������
    if iter==1;
        [min_Length,min_index]=min(Length);
        Length_best(iter)=min_Length;
        Length_ave(iter)=mean(Length);  %mean�������ƽ�������߾�ֵ
        Route_best(iter,:)=Table(min_index,:);
    else
        [min_Length,min_index]=min(Length);
        Length_best(iter)=min(Length_best(iter-1),min_Length);
        Length_ave(iter)=mean(Length);
        if Length_best(iter)==min_Length
            Route_best(iter,:)=Table(min_index,:);
        else
            Route_best(iter,:)=Route_best((iter-1),:);
        end 
    end
    
    %������Ϣ��
    Delta_Tau=zeros(n,n);
    %������ϼ���
    for i=1:m
        %������м���
        for j=1:(n-1)
            Delta_Tau(Table(i,j),Table(i,j+1))=Delta_Tau(Table(i,j),Table(i,j+1))+Q/Length(i);
        end
        Delta_Tau(Table(i,n),Table(i,1))=Delta_Tau(Table(i,n),Table(i,1))+Q/Length(i);
    end
    Tau=(1-rho)*Tau+Delta_Tau;
    
    %����������1�����·����¼��
    iter=iter+1;
    Table=zeros(m,n);
end


%%�����ʾ
[Shortest_Length,index]=min(Length_best);
Shortest_Route=Route_best(index,:);
disp(['��̾��룺' num2str(Shortest_Length)]);
disp(['���·����' num2str([Shortest_Route Shortest_Route(1)])]);

%%��ͼ

figure(1)
plot([citys(Shortest_Route,1);citys(Shortest_Route(1),1)],[citys(Shortest_Route,2);citys(Shortest_Route(1),2)],'o-');
grid on
    for i=1:size(citys,1)
    text(citys(i,1),citys(i,2),[' ' num2str(i)]);
    end
 text(citys(Shortest_Route(1),1),citys(Shortest_Route(1),2),'    ���');
 text(citys(Shortest_Route(end),1),citys(Shortest_Route(end),2),'    �յ�');
xlabel( ' ����λ�ú�����')
ylabel(' ����λ��������')
title(['��Ⱥ�㷨�Ż�·������̾��룺' num2str(Shortest_Length) ')'])
figure(2)
plot(1:iter_max,Length_best,'b',1:iter_max,Length_ave,'r')
legend('��̾���','ƽ������')
xlabel('��������')
ylabel('����')
title('������̾�����ƽ������Ա�')




