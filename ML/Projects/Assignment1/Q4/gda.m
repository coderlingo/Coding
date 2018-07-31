load q4x.dat;
X=q4x;
[m,n]=size(X);
Y1=importdata('q4y.dat');

Y=zeros(1,m);
for i=1:m
    if strcmp(Y1(i),'Alaska')
        Y(i)=1;
    else
        Y(i)=0;
    end
end
mean0=zeros(1,n);
p=0;
for i=1:m
    if Y(i)==0
       mean0(1)=mean0(1)+X(i,1);
       mean0(2)=mean0(2)+X(i,2);       
       p=p+1;
    end
end
mean0=mean0./p;
mean1=zeros(1,n);
p=0;
for i=1:m    
    if Y(i)==1
       mean1(1)=mean1(1)+X(i,1);
       mean1(2)=mean1(2)+X(i,2);
       p=p+1;
    end
end
mean1=mean1./p;
disp('Mean0');
disp(mean0);
disp('Mean1');
disp(mean1);

%first part
X2=zeros(m,2);
for i=1:m
    if Y(i)==0
        X2(i,1)=X(i,1)-mean0(1);
        X2(i,2)=X(i,2)-mean0(2);
    else
        X2(i,1)=X(i,1)-mean1(1);
        X2(i,2)=X(i,2)-mean1(2);
    end
end
sigma=zeros(n,n);
for i=1:m
    sigma=sigma+X2(i,:)'*X2(i,:);
    
end
sigma=sigma.*(1/m);
display(sigma);

%plot the training data
hold on
for i=1:m
    if Y(i)==1
        scatter(X(i,1),X(i,2),'red','+');
    else
        scatter(X(i,1),X(i,2),'blue','o');
    end
end
hold off

%decision boundary 

phi=0;
for i=1:m
    if Y(i)==1
        phi=phi+1;
    end
end
phi=phi./m;
sigma_inv=inv(sigma);
temp=mean1*sigma_inv-mean0*sigma_inv;
coeff=zeros(m,2);
for i=1:m
    coeff(i,:)=temp.*X(i,:);
end
const=[(mean1*sigma_inv*mean1')-(mean0*sigma_inv*mean0')]*.5;
const=const+log(1-phi)-log(phi);
%decision_boundary=temp-const;
x=zeros(1,m);
for i=1:m
    x(i)=const-coeff(i,1);
    display(x(i));
    x(i)=x(i)/temp(1,2);
end
hold on
plot(X(:,1),x);
hold off
figure;
%QDA(d)
sigma_zero=zeros(n,n);
p=0;
for i=1:m
    if Y(i)==0
        p=p+1;
        sigma_zero=sigma_zero+X2(i,:)'*X2(i,:);
    end
end
sigma_zero=sigma_zero.*(1/p);

sigma_one=zeros(n,n);
p=0;
for i=1:m
    sigma_one=sigma_one+(Y(i))*X2(i,:)'*X2(i,:);
    if Y(i)==1
        p=p+1;
    end
end
sigma_one=sigma_one.*(1/p);

%decision boundary (e)
hold on
for i=1:m
    if Y(i)==1
        scatter(X(i,1),X(i,2),'red','+');
    else
        scatter(X(i,1),X(i,2),'blue','o');
    end
end
hold off
A=(.5)*(inv(sigma_one)-inv(sigma_zero));
B=(mean0*inv(sigma_zero)-mean1*inv(sigma_one));
C=(.5)*(mean1*inv(sigma_one)*mean1'-mean0*inv(sigma_zero)*mean0')+0.5*log(det(sigma_one)/det(sigma_zero))+log((1-phi)/phi);
a=A(2,2);

X1 = 50:5:200;
q=0;
for i=1:length(X1)
    b=A(2,1)*X1(i)+A(1,2)*X1(i)+B(1,2);
    c=A(1,1)*X1(i)*X1(i)+B(1,1)*X1(i)+C;
    q=b*b-4*a*c;
    f(i)=q;
    qb(i)=(-b-sqrt(q))/(2*a);
end
hold on
plot(X1,qb);
hold off
