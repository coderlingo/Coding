data1=importdata('train.data');
data2=importdata('test.data');
test_data=data2.data;
data=data1.data;
%{'H','B','L','X','F'}
H=zeros(1,2);
B=zeros(2,2);%H,B
L=zeros(2,2);%H,L
X=zeros(2,2);%L,X
F=zeros(2,2,2);%B,L,F

%parents
parent_H=[0];
parent_L=[1];
parent_B=[1];
parent_X=[3];
parent_F=[2,3];

%separate coulmns
H_data=data(:,1);
B_data=data(:,2);
L_data=data(:,3);
X_data=data(:,4);
F_data=data(:,5);


%finding the discreet values 
H_unique=[0,1];
L_unique=[0,1];
B_unique=[0,1];
F_unique=[0,1];
X_unique=[0,1];

%For H
H_1=sum(H_data==1);
H_0=sum(H_data==0);
H(1,1)=H_0/double(size(H_data,1));
H(1,2)=H_1/double(size(H_data,1));

%For B
B_0=find(B_data==0);
B_1=find(B_data==1);
H_0=find(H_data==0);
H_1=find(H_data==1);

B(1,1)=length(intersect(B_0,H_0))/length(H_0);
B(1,2)=length(intersect(B_1,H_0))/length(H_0);
B(2,1)=length(intersect(B_0,H_1))/length(H_1);
B(2,2)=length(intersect(B_1,H_1))/length(H_1);

%for L
L_0=find(L_data==0);
L_1=find(L_data==1);
H_0=find(H_data==0);
H_1=find(H_data==1);

L(1,1)=length(intersect(L_0,H_0))/length(H_0);
L(1,2)=length(intersect(L_1,H_0))/length(H_0);
L(2,1)=length(intersect(L_0,H_1))/length(H_1);
L(2,2)=length(intersect(L_1,H_1))/length(H_1);

%for X
X_0=find(X_data==0);
X_1=find(X_data==1);
L_0=find(L_data==0);
L_1=find(L_data==1);

X(1,1)=length(intersect(X_0,L_0))/length(L_0);
X(1,2)=length(intersect(X_1,L_0))/length(L_0);
X(2,1)=length(intersect(X_0,L_1))/length(L_1);
X(2,2)=length(intersect(X_1,L_1))/length(L_1);


%for F
F_0=find(F_data==0);
F_1=find(F_data==1);
L_0=find(L_data==0);
L_1=find(L_data==1);
B_0=find(B_data==0);
B_1=find(B_data==1);

F(1,1,1)=length(intersect(intersect(F_0,L_0),B_0))/length(intersect(B_0,L_0));
F(1,2,1)=length(intersect(intersect(F_0,L_1),B_0))/length(intersect(B_0,L_1));
F(2,1,1)=length(intersect(intersect(F_0,L_0),B_1))/length(intersect(B_1,L_0));
F(2,2,1)=length(intersect(intersect(F_0,L_1),B_1))/length(intersect(B_1,L_1));
F(1,1,2)=length(intersect(intersect(F_1,L_0),B_0))/length(intersect(B_0,L_0));
F(1,2,2)=length(intersect(intersect(F_1,L_1),B_0))/length(intersect(B_0,L_1));
F(2,1,2)=length(intersect(intersect(F_1,L_0),B_1))/length(intersect(B_1,L_0));
F(2,2,2)=length(intersect(intersect(F_1,L_1),B_1))/length(intersect(B_1,L_1));

%------LOG LIKELY HOOD
log_sum=0;
for i=1:size(test_data,1)
   D=test_data(i,:);
   display(log_sum)
   for j=1:size(D,2)
       
      if j==1
          %H
          H_val=D(j)+1;
          log_sum=log_sum+log(H(H_val))
      end
      if j==2
          %B
          B_val=D(j)+1;
          H_val=D(1)+1;
          log_sum=log_sum+log(B(H_val,B_val))
      end
      if j==3
          %L
          L_val=D(j)+1;
          H_val=D(1)+1;
          log_sum=log_sum+log(L(H_val,L_val))
      end
      if j==4
          %X
          X_val=D(j)+1;
          L_val=D(3)+1;
          log_sum=log_sum+log(X(L_val,X_val))
      end
      if j==5
          %F
          F_val=D(j)+1;
          B_val=D(2)+1;
          L_val=D(3)+1;
          log_sum=log_sum+log(F(B_val,L_val,F_val))
      end
   end
   
end

display(log_sum);











