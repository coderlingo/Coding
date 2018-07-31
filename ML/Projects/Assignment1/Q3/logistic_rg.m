load q2x.dat;
X=q2x;

fid=fopen('q2y.dat','r');
Y= fscanf(fid, '%f');
fclose(fid);
%disp('Y=')
[m,n]=size(X);
arr=ones(m,1);
X=[arr X];
theta=zeros(1,n+1);
temp=zeros(1,m);
loop=1;con=.0000001;
k=0;
while loop==1
    for i=1:m
        temp(i)=theta*X(i,:)';
    end
    h_theta=zeros(1,m);
    for i=1:m
        h_theta(i)=1/(1+exp(-temp(i)));
    end
    error=zeros(1,n+1);
    single_der=zeros(1,1+n);
    for j=1:n+1
        for i=1:m
            single_der(j)=single_der(j)+(Y(i).*X(i,j))-(h_theta(i).*X(i,j));
        end
    end
    double_der=zeros(n+1,n+1);
    for j=1:n+1
        for k=1:n+1
            for i=1:m
                sig=(1+exp(temp(i)))^-2;
                sig=sig.*exp(temp(i));
                sig=sig.*X(i,k).*X(i,j);
                double_der(j,k)=(double_der(j,k)-sig);
            end
        end
    end
    theta_old=theta;
    newton_ratio=single_der*inv(double_der);
    for i=1:n+1
        theta(i)=theta(i)-newton_ratio(i);
    end
    diff=theta-theta_old;
    flag=0;
    for i=1:n+1
        if diff(i)>con
            flag=1;
            break
        end
    end
    if flag==0
        loop=0;
    end
    k=k+1;
end
disp(theta);
for i=1:m
    h_theta(i)=1/(1+exp(-temp(i)));
end
pos = find(Y == 1);
neg = find(Y == 0);
hold on;
plot(X(pos, 2), X(pos,3), 'r+');

plot(X(neg, 2),X(neg, 3), 'bo');

y=-theta(1)/theta(3)-(theta(2)/theta(3))*X(:,2);
plot(X(:,2),y);
hold off;