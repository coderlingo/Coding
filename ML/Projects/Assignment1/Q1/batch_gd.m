fid=fopen('q1x.dat','r');
X= fscanf(fid, '%f');
fclose(fid);

fid=fopen('q1y.dat','r');
Y= fscanf(fid, '%f');
fclose(fid);
[m,n]=size(X);
arr=ones(m,1);
X=[X arr];
theta=zeros(1,n+1);
disp(theta)
theta_old(1:n+1)=10;
learning_rate=1.3;
con=.0000001;
loop = 1;
%disp(error)
meanx = mean(X(:,1));
varx = var(X(:,1));

%Code to normalize data
for i = 1:m
	X(i,1) = (X(i,1) - meanx) / sqrt(varx) ;
end
k=1;
theta_array=[];
j_theta=zeros(1,1);
j_theta=[];
temp=(X*theta'- Y)'*(X*theta' - Y);
j_theta(k)= temp*(0.5*(1/m));
while loop==1
    error=zeros(1,n+1);
    for i=1:m
        for j=1:n+1
            h_theta=theta*X(i,:)';
            temp=Y(i)-h_theta;
            error(j)=error(j)+temp.*X(i,j);
        end
    end
    theta_old=theta;
    for i=1:n+1
        
        theta(i)=theta(i)+learning_rate.*error(i)*(1/m);
        
    end
    diff=theta-theta_old;
    flag=0;
    for i=1:n+1
        if diff(i)>con
            flag=1;
            break
        end
    end
   
    k=k+1;
    theta_array=[theta_array,[theta(1);theta(2)]];
    temp=(X*theta'- Y)'*(X*theta' - Y);
    j_theta(k)= temp*(0.5*(1/m));
    if abs(j_theta(k-1)-j_theta(k))<con
        loop=0;
        disp('end');
    end
    
end

disp(theta)
%disp(k);
%display(j_theta);
figure(1);
hold on
scatter(X(:,1),Y,'.');
X1=sort(X);
plot(X1(:,1),theta*X1');
hold off
figure(2);
theta1=-20:1:20;
theta2=-20:1:20;
j_theta1=zeros(length(theta2),length(theta1));
u = 0;
for i=1:length(theta1)
    for j=1:length(theta2)
        t = [theta1(i) theta2(j)];
        temp=(X*t'- Y)'*(X*t' - Y);
        j_theta1(j,i)= temp*(0.5*(1/m));
    end
end

hold on;
surf(theta1,theta2,j_theta1);
h=animatedline('color','r','LineWidth',5); 
for i=1:k-1
    addpoints(h,theta_array(1,i),theta_array(2,i),j_theta(i));
    drawnow;
end
hold off;
figure(3);
hold on;
contour(theta1,theta2,j_theta1,200);
h=animatedline('color','b','LineWidth',5); 
for i=1:k-1
    addpoints(h,theta_array(1,i),theta_array(2,i),j_theta(i));
    drawnow;
end
hold off;
