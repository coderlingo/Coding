fid=fopen('q3x.dat','r');
X= fscanf(fid, '%f');
fclose(fid);


fid=fopen('q3y.dat','r');
Y= fscanf(fid, '%f');
fclose(fid);
[m,n]=size(X);
arr=ones(m,1);
X=[X arr];
temp=X'*X;
temp=inv(temp);
theta=temp*X'*Y;
display(theta);
scatter(X(:,1) , Y);
figure(1);
hold on
plot(X(:,1) , theta'*X');
hold off
%part 2
h_theta=zeros(1,m);
query=zeros(1,m);
j=1;
tow=.8;
theta=zeros(1,n+1);
X1=X;
X1=sort(X1);
while(j<=m)
    x=X1(j,:);
    W=zeros(1,m);
    for i=1:m
        W(i)=exp(-((x(1,1)-X(i,1))^2)./(2.*(tow^2)));
    end
    W1=zeros(m,m);
    W1=diag(W);
    W=zeros(m,m);
    W=W1;
    temp=(X'*(W*X));
    temp=inv(temp);
    theta=temp*X'*W*Y;
    h_theta(j)=theta'*x';
    query(j)=x(1,1);
    j=j+1;
end
figure(2);
scatter(X(:,1) , Y);
hold on
plot(query , h_theta);
hold off