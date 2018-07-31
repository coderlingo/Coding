imported_data=importdata('digitdata.txt');
data=imported_data.data;
A=3:5:783;
B=zeros(1000,784);
for i=1:1000
   B(i,A)=data(i,:);
end
Sum_plot=zeros(20,1);
%-----INITIALIZE
error=.00001;

itr=1;
flag=1;
mu=zeros(4,784);
random_mu=randi(1000,1,4);
C=zeros(1000,1);
for i=1:4
    mu(i,:)=B(random_mu(i),:);
end
while itr~=21 & flag ==1
    count_j1=0;
    count_j2=0;
    count_j3=0;
    count_j4=0;

    count_j1_x=zeros(1,784);
    count_j2_x=zeros(1,784);
    count_j3_x=zeros(1,784);
    count_j4_x=zeros(1,784);        
    for i=1:1000
        max=99999;
        max_index=-1;
        for j=1:4
            if norm(B(i,:)-mu(j,:))<max
                max=norm(B(i,:)-mu(j,:));
                max_index=j;
            end
        end
        C(i)=max_index;
        if max_index==1
            count_j1=count_j1+1;
            count_j1_x=count_j1_x+B(i,:);
        else if max_index==2
                count_j2=count_j2+1;
                count_j2_x=count_j2_x+B(i,:);
            else if max_index==3
                    count_j3=count_j3+1;
                    count_j3_x=count_j3_x+B(i,:);
                else if max_index==4
                        count_j4=count_j4+1;
                        count_j4_x=count_j4_x+B(i,:);
                    end
                end
            end
        end
    end
    
    mu(1,:)=(count_j1_x)/double(count_j1);
    mu(2,:)=(count_j2_x)/double(count_j2);
    mu(3,:)=(count_j3_x)/double(count_j3);
    mu(4,:)=(count_j4_x)/double(count_j4);


    sum_itr=0;
    for index=1:1000
        sum_itr=sum_itr+(norm(B(index,:)-mu(C(index),:)))^2;
    end
    Sum_plot(itr)=sum_itr;
    itr=itr+1;
end



X=1:1:20;
plot(X,Sum_plot);
xlabel('iterations') % x-axis label
ylabel('S') % y-axis label
