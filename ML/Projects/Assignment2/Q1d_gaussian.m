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


%%gaussian SVM
model = svmtrain(Y, X, '-s 0 -t 2 -c 1 -g 0.00025 -q'); %% -g 0.00025

[predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_Y, test_X, model);
libsvm_gaussian_sv = model.sv_indices ;
