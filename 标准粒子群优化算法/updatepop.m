%����Ⱥ�ٶ���λ�ø���

%���������ٶ�
for i=1:popsize
    pop(i,3)=rand()*pop(i,3)+c1*rand()*(pop(i,5)-pop(i,1))+c2*rand()*(gbest_x-pop(i,1));    %�����ٶ�
    pop(i,4)=rand()*pop(i,4)+c1*rand()*(pop(i,6)-pop(i,2))+c2*rand()*(gbest_x-pop(i,2)); 
    if abs(pop(i,3))>max_velocity
        if pop(i,3)>0
            pop(i,3)=max_velocity;
        else
            pop(i,3)=-max_velocity;
        end
    end
    if abs(pop(i,4))>max_velocity
        if pop(i,4)>0
            pop(i,4)=max_velocity;
        else
            pop(i,4)=-max_velocity;
        end
    end
end

%��������λ��
for i=1:popsize
    pop(i,1)=pop(i,1)+pop(i,3);
    pop(i,2)=pop(i,2)+pop(i,4);
end
