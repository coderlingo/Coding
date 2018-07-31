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

p1=0;
p2=0;
p3=0;
sum1=0;
sum2=0;
sum3=0;
for i=1:n
    if X(i,1)~=0
        sum1=sum1+X(i,1);
        p1=p1+1;
    end
    if X(i,2)~=0
        sum2=sum2+X(i,1);
        p2=p2+1;
    end
    if X(i,3)~=0
        sum3=sum3+X(i,1);
        p3=p3+1;
    end
end
avg1=floor(sum1/p1);
avg2=floor(sum2/p2);
avg3=floor(sum3/p3);

for i=1:n
    if X(i,1)==0
        X(i,1)=avg1;
    end
    if X(i,2)==0
        X(i,2)=avg2;
    end
    if X(i,3)==0
        X(i,3)=avg3;
    end
end
%%linear SVM
model1 = svmtrain(Y, X, '-s 0 -t 0 -c 1 -q');


[predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_Y, test_X, model1);

