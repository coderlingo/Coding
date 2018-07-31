input = fileread('train.data');
correct_data = strrep(input, 'nonad', '-1');
correct_data = strrep(correct_data, 'ad', '1');
fid = fopen('newtrain.data','wt');
fprintf(fid, correct_data);
fclose(fid);
M = csvread('newtrain.data');
Y = M(:, 1559);
X = M(:, 1:(end-1));

inputTest = fileread('test.data');
correct_data = strrep(inputTest, 'nonad', '-1');
correct_data = strrep(correct_data, 'ad', '1');
fid = fopen('newtest.data','wt');
fprintf(fid, correct_data);
fclose(fid);
newTest = csvread('newtest.data');
YTest = newTest(:, 1559);
XTest = newTest(:, 1:(end-1));
[mtest,n]=size(XTest);

for 

%%linear SVM
model1 = svmtrain(Y, X, '-s 0 -t 0 -c 1 -q');


[predict_label_L, accuracy_L, dec_values_L] = svmpredict(YTest, XTest, model1);
libsvm_linear_sv = model1.sv_indices ;
