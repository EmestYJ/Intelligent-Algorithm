clear all
clc
%***********1����ı��롢2������ʼ��Ⱥ��3������Ӧֵ*******

N=20;
%���������
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
%***************4����ѡ��*****************

for diedai=1:660

%������Ⱥ������Ⱦɫ����Ӧֵ֮��
F=0;
for i=1:N
    F=F+y(i);
end

for k=2:(N+1)
     T(1)=0;
    %����ÿ��Ⱦɫ���ѡ�����
    P(k-1)=y(k-1)/F;
    %����ÿ��Ⱦɫ����ۼƸ���
    T(k)=T(k-1)+P(k-1);
    q(k-1)=T(k);
end

%����ת��N�Σ�����ѡ��N��Ⱦɫ�壬���Ϊn(1-20)
for i=1:N
    r=rand;
    
    j=1;
    while (r>q(j)) 
        j=j+1 ;
    end
    max(j);
    m(i)=max(j)-1;
end
%��m(i)�е�0��Ϊ1�����಻��
for i=1:N
    if (m(i)==0)
        m(i)=1;
    end
    n(i)=m(i);
end 
%***********5�ӽ�***********

%�ҳ�Ҫ�����ӽ��ĸ���
pc=0.25;
a=[];
for i=1:N
    R(i)=rand;
    while(R(i)<pc)
        A=[a,i];                    %�ѽ��i��������A��
        a=A;
        break
    end
end
%a(1)
[mm,nn]=size(a);             %���������a��С��ͬ������
zaj_length=nn;               %����a������

%ȷ�������ӽ���Ⱦɫ����
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
            %���������[1,32]�е�һ������pos
    pos=randi([1,32],1,1);   %���ɵģ�M,N)��(1,1) ������������������,
                                  %�� 0 ���͡� 1 �����ֵĸ��ʾ���
    p(b(2*i-1),:)= [p(b(2*i-1),1:(pos)),p(b(2*i),(pos+1):33)];
    p(b(2*i),:)= [p(b(2*i),1:(pos)),p(b(2*i-1),(pos+1):33)];
end


%********6����******
%pos=randint(1,1,[1,660]);
pm=0.01;
h=[];
for i=1:660
    RM(i)=rand;
    while(RM(i)<pm)
        H=[h,i];   %�������죬�ѽ��i��������H��
        h=H;
        break
    end
end

[hm,hn]=size(h);
hnm=hn;         %�����Ļ����λ�ø���������h������
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


 