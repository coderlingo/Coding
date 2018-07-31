imported_data=importdata('digitdata.txt');
import_data=importdata('digitlabels.txt');
Y=import_data.data;
data=imported_data.data;
A=3:5:783;
B=zeros(1000,784);
for i=1:1000
   B(i,A)=data(i,:);
end
%-----INITIALIZE
itr=1;
error=.00001;
flag=1;
mu=zeros(4,784);
random_mu=randi(1000,1,4);
C=zeros(1000,1);
count_j1_x=zeros(1,784);
count_j2_x=zeros(1,784);
count_j3_x=zeros(1,784);
count_j4_x=zeros(1,784);

%----loooooopppp

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
    
    %--INDEXES OF THE CLUSTERS
    cluster1=find(C==1);
    cluster2=find(C==2);
    cluster3=find(C==3);
    cluster4=find(C==4);

    %--actual values of the cluster points
    cluster1_acc_val=Y(cluster1,1);
    cluster2_acc_val=Y(cluster2,1);
    cluster3_acc_val=Y(cluster3,1);
    cluster4_acc_val=Y(cluster4,1);

    %--max occuring value in the cluster
    cluster1_val_mode=mode(cluster1_acc_val);
    cluster2_val_mode=mode(cluster2_acc_val);
    cluster3_val_mode=mode(cluster3_acc_val);
    cluster4_val_mode=mode(cluster4_acc_val);


    %--cluster output values
    cluster1_val=C(cluster1,1);
    cluster2_val=C(cluster2,1);
    cluster3_val=C(cluster3,1);
    cluster4_val=C(cluster4,1);

    %--acctual number of times a value occurs in a vector
    sum_mode_val_1=sum(cluster1_acc_val==cluster1_val_mode);
    sum_mode_val_2=sum(cluster2_acc_val==cluster2_val_mode);
    sum_mode_val_3=sum(cluster3_acc_val==cluster3_val_mode);
    sum_mode_val_4=sum(cluster4_acc_val==cluster4_val_mode);

    %--accuracies

    acc1=sum_mode_val_1/size(cluster1,1);
    acc2=sum_mode_val_2/size(cluster2,1);
    acc3=sum_mode_val_3/size(cluster3,1);
    acc4=sum_mode_val_4/size(cluster4,1);
    avg_acc1=4-acc1-acc2-acc3-acc4;
    avg_acc(itr)=avg_acc1/4;
    
    itr=itr+1;
end


X=1:1:20;
plot(X,avg_acc);
xlabel('iterations') % x-axis label
ylabel('ERROR') % y-axis label