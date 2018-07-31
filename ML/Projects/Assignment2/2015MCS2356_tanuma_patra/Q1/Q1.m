%reading from train file
tmp_input = fileread('train.data');
correct_data = strrep(tmp_input, 'nonad', '-1');
correct_data = strrep(correct_data, 'ad', '1');
fid = fopen('newtrain.data','wt');
fprintf(fid, correct_data);
fclose(fid);
load newtrain.data;
Y = newtrain(:, 1559);
X = newtrain(:, 1:(end-1));
[n,m]=size(X);

%reading from train file
test_tmp_input = fileread('test.data');
test_correct_data = strrep(test_tmp_input, 'nonad', '-1');
test_correct_data = strrep(test_correct_data, 'ad', '1');
fid = fopen('newtest.data','wt');
fprintf(fid, test_correct_data);
fclose(fid);
load newtest.data;
test_Y = newtest(:, 1559);
test_X = newtest(:, 1:(end-1));
[test_n,test_m]=size(test_X);

X_pair=X*X';
Y_pair = Y*Y';
Q = Y_pair.*X_pair;
Ones=ones(n,1);
cvx_begin
    variable a(n) 
    maximize(-0.5*a'*Q*a + Ones'*a);
    subject to
        Y'*a == 0;
        0<=a<=1;
cvx_end
%number of support vectors
svmG = find(a>0.0005&a<0.9999);
display(svmG);
%vaue of w
w=zeros(m,1);
for j=1:m
    for i=1:n
        w(j,:)=w(j,:)+a(i)*Y(i)*X(i,j);
    end
end
display(w);

%values of b
w_t_x=X*w;
max=0;
min=0;
for i=1:n
    if Y(i)==-1
        if max<w_t_x(i)
            max=w_t_x(i);
        end
    end
    if Y(i)==1
        if min >w_t_x(i)
            min=w_t_x(i);
        end
    end
end
b=-(max+min)*.5;
predicted_y = test_X*w+b;

for i=1:test_n
    if predicted_y(i)<0
        predicted_y(i)=-1;
    else
        predicted_y(i)=1;
    end
end
acc=0;
for i=1:test_n
    if test_Y(i)==predicted_y(i)
        acc=acc+1;
    end
end
acc = acc/test_n;
display('ACCURACY:');
disp(acc*100);



        