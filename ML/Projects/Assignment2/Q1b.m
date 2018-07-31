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

%Q1 part c
%calculating kernal matrix
gama=.00025;
cons=-gama;
Q = zeros(n,n);
for i=1:n
    for j=1:n
       difference = X(i,:) - X(j,:) ;
        t = norm(difference);
        normSquare = t^2 ;
        Q(i,j) = Y(i)*Y(j)*exp(cons*normSquare);
    end
end

Ones=ones(n,1);
cvx_begin
    variable a(n) 
    maximize(-0.5*a'*Q*a + Ones'*a);
    subject to
        Y'*a == 0;
        0<=a<=1;
cvx_end

%support vectors
svmG = find(a>0.0005&a<0.9999);
display(svmG);
%test
Wg = K'*(a.*Y);

max=0;
min=0;
for i=1:n
    if Y(i)==-1
        if max<Wg(i)
            max=Wg(i);
        end
    end
    if Y(i)==1
        if min >Wg(i)
            min=Wg(i);
        end
    end
end
b=-(max+min)*.5;

% 
% pos=find(Y==1);
% neg=find(Y==-1);
% posWTransposeXg = Wg(pos);
% negWTransposeXg = Wg(neg);
% b = -(max(negWTransposeXg) + min(posWTransposeXg))/2 ;
K_Test = zeros(n,test_n);
for i = 1:n
    for j = 1:test_n
    difference = X(i,:) - test_X(j,:) ;
    t = norm(difference);
    normSquare = t^2 ;
    K_Test(i,j) = exp(cons*normSquare);
    end
end


Wt = K_Test'*(a.*Y);
new_Y = test_Y.*(Wt+ b) ;
correctData = length(find(new_Y > 0));
accuracy = (correctData/test_n)*100;
display(accuracy);

