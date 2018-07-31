%getting the data
data=importdata('20ng-rec_talk.txt');
input=data;
[m,n]=size(data);

distinct_y=char('rec.autos','rec.motorcycles','rec.sport.baseball','rec.sport.hockey','talk.politics.guns','talk.politics.mideast','talk.politics.misc','talk.religion.misc');

%building the vocabulary
fid=fopen('20ng-rec_talk.txt');
words = textread('20ng-rec_talk.txt','%s');
words=char(words);
words=sortrows(words);
words=unique(words,'rows');
x=strmatch('rec.autos',words);
words(x,:)=[];
x=strmatch('rec.motorcycles',words);
words(x,:)=[];
x=strmatch('rec.sport.baseball',words);
words(x,:)=[];
x=strmatch('rec.sport.hockey',words);
words(x,:)=[];
x=strmatch('talk.politics.guns',words);
words(x,:)=[];
x=strmatch('talk.politics.mideast',words);
words(x,:)=[];
x=strmatch('talk.politics.misc',words);
words(x,:)=[];
x=strmatch('talk.religion.misc',words);
words(x,:)=[];

%map for vocabulary
a=size(words,1);
vocab_valueset=1:1:a;
mapObj_vocab=containers.Map(cellstr(words),vocab_valueset);


%map for classes
class_valueset=1:1:8;
mapObj_class=containers.Map(cellstr(distinct_y),class_valueset);

if ~exist('preprocess_matrix')
   [preprocess_matrix , Y,Y_index]=pre_process(m,data,size(words,1),mapObj_vocab,mapObj_class);
   save('preprocess_matrix.mat','preprocess_matrix','Y_index');
   save('Y.mat','Y','Y_index');
end
    
choise =1;
%separating the data into training and test set
i=m;

num_points = size(data,1);
split_point = num_points/5;
seq = randperm(num_points);
for i=1:5
    display(i);
    if i==1
        data1 = preprocess_matrix(seq(split_point*(i-1)+1:split_point*i),:);
        Y1=cellstr(Y);
        Y1=Y1(:,seq(split_point*(i-1)+1:split_point*i));
        Y_index1=Y_index(seq(split_point*(i-1)+1:split_point*i),:);
    end
    if i==2
        data2 = preprocess_matrix(seq(split_point*(i-1)+1:split_point*i),:);
        Y2=cellstr(Y);
        Y2=Y2(:,seq(split_point*(i-1)+1:split_point*i));
        Y_index2=Y_index(seq(split_point*(i-1)+1:split_point*i),:);
    end
    if i==3
        data3 = preprocess_matrix(seq(split_point*(i-1)+1:split_point*i),:);
        Y3=cellstr(Y);
        Y3=Y3(:,seq(split_point*(i-1)+1:split_point*i));
        Y_index3=Y_index(seq(split_point*(i-1)+1:split_point*i),:);
    end
    if i==4
        data4 = preprocess_matrix(seq(split_point*(i-1)+1:split_point*i),:);
        Y4=cellstr(Y);
        Y4=Y4(:,seq(split_point*(i-1)+1:split_point*i));
        Y_index4=Y_index(seq(split_point*(i-1)+1:split_point*i),:);
    end
    if i==5
        data5 = preprocess_matrix(seq(split_point*(i-1)+1:split_point*i),:);
        Y5=cellstr(Y);
        Y5=Y5(:,seq(split_point*(i-1)+1:split_point*i));
        Y_index5=Y_index(seq(split_point*(i-1)+1:split_point*i),:);
    end
    
end


%train and test data
train1=[data1;data2;data3;data4];
Y_train1=[Y1,Y2,Y3,Y4];

[prob_mat,y_sum]=traindata(train1,Y_train1,distinct_y,mapObj_vocab,mapObj_class);
acc1=testdata(data5,Y5,Y_index5,prob_mat,y_sum,mapObj_class);

train2=[data1;data2;data3;data5];
Y_train2=[Y1,Y2,Y3,Y5];
[prob_mat,y_sum]=traindata(train2,Y_train2,distinct_y,mapObj_vocab,mapObj_class);
acc2=testdata(data4,Y4,Y_index4,prob_mat,y_sum,mapObj_class);


train3=[data1;data2;data4;data5];
Y_train3=[Y1,Y2,Y4,Y5];
[prob_mat,y_sum]=traindata(train3,Y_train3,distinct_y,mapObj_vocab,mapObj_class);
acc3=testdata(data3,Y3,Y_index3,prob_mat,y_sum,mapObj_class);


train4=[data1;data3;data4;data5];
Y_train4=[Y1,Y3,Y4,Y5];
[prob_mat,y_sum]=traindata(train4,Y_train4,distinct_y,mapObj_vocab,mapObj_class);
acc4=testdata(data2,Y2,Y_index2,prob_mat,y_sum,mapObj_class);


train5=[data2;data3;data4;data5];
Y_train5=[Y2,Y3,Y4,Y5];
[prob_mat,y_sum]=traindata(train5,Y_train5,distinct_y,mapObj_vocab,mapObj_class);
acc5=testdata(data1,Y1,Y_index1,prob_mat,y_sum,mapObj_class);

display(acc1);
display(acc2);
display(acc3);
display(acc4);
display(acc5);



%part d
Y_index_1=[Y_index1;Y_index2;Y_index3;Y_index4];
Y_index_2=[Y_index1;Y_index2;Y_index3;Y_index5];
Y_index_3=[Y_index1;Y_index2;Y_index4;Y_index5];
Y_index_4=[Y_index1;Y_index3;Y_index4;Y_index5];
Y_index_5=[Y_index2;Y_index3;Y_index4;Y_index5];
accuracy1=zeros(5,1);
accuracy2=zeros(5,1);
accuracy3=zeros(5,1);
accuracy4=zeros(5,1);
accuracy5=zeros(5,1);
accuracy1_train=zeros(5,1);
accuracy2_train=zeros(5,1);
accuracy3_train=zeros(5,1);
accuracy4_train=zeros(5,1);
accuracy5_train=zeros(5,1);
for j=1:5
	for i=1:5
		num_points = size(train1,1);
		split_point = 1000*i;
		seq = randperm(num_points);
		if j==1
			t1=train1(seq(1:split_point),:);
			Y_t1=Y_train1(:,seq(1:split_point));
            Y_ind1=Y_index_1(seq(1:split_point),:);
			[prob_mat,y_sum]=traindata(t1,Y_t1,distinct_y,mapObj_vocab,mapObj_class);
			accuracy1(i)=testdata(data5,Y5,Y_index5,prob_mat,y_sum,mapObj_class);
            accuracy1_train(i)=testdata(t1,Y_t1,Y_ind1,prob_mat,y_sum,mapObj_class);
		end
		if j==2
			t2=train2(seq(1:split_point),:);
			Y_t2=Y_train2(:,seq(1:split_point));
            Y_ind2=Y_index_2(seq(1:split_point),:);
			[prob_mat,y_sum]=traindata(t2,Y_t2,distinct_y,mapObj_vocab,mapObj_class);
			accuracy2(i)=testdata(data4,Y4,Y_index4,prob_mat,y_sum,mapObj_class);
            accuracy2_train(i)=testdata(t2,Y_t2,Y_ind2,prob_mat,y_sum,mapObj_class);
		end
		if j==3
			t3=train3(seq(1:split_point),:);
			Y_t3=Y_train3(:,seq(1:split_point));
            Y_ind3=Y_index_2(seq(1:split_point),:);
			[prob_mat,y_sum]=traindata(t3,Y_t3,distinct_y,mapObj_vocab,mapObj_class);
			accuracy3(i)=testdata(data3,Y3,Y_index3,prob_mat,y_sum,mapObj_class);
            accuracy3_train(i)=testdata(t3,Y_t3,Y_ind3,prob_mat,y_sum,mapObj_class);
		end
		if j==4
			t4=train4(seq(1:split_point),:);
			Y_t4=Y_train4(:,seq(1:split_point));
            Y_ind4=Y_index_2(seq(1:split_point),:);
			[prob_mat,y_sum]=traindata(t4,Y_t4,distinct_y,mapObj_vocab,mapObj_class);
			accuracy4(i)=testdata(data2,Y2,Y_index2,prob_mat,y_sum,mapObj_class);
            accuracy4_train(i)=testdata(t4,Y_t4,Y_ind4,prob_mat,y_sum,mapObj_class);
		end
		if j==5
			t5=train5(seq(1:split_point),:);
			Y_t5=Y_train5(:,seq(1:split_point));
            Y_ind5=Y_index_2(seq(1:split_point),:);
			[prob_mat,y_sum]=traindata(t5,Y_t5,distinct_y,mapObj_vocab,mapObj_class);
			accuracy5(i)=testdata(data1,Y1,Y_index1,prob_mat,y_sum,mapObj_class);
            accuracy5_train(i)=testdata(t5,Y_t5,Y_ind5,prob_mat,y_sum,mapObj_class);
		end
		
	end
	
end

display(accuracy1);
display(accuracy2);
display(accuracy3);
display(accuracy4);
display(accuracy5);
acc_test=[mean(accuracy1),mean(accuracy2),mean(accuracy3),mean(accuracy4),mean(accuracy5)];
acc_train=[mean(accuracy1_train),mean(accuracy2_train),mean(accuracy3_train),mean(accuracy4_train),mean(accuracy5_train)];
X=1000:1000:5000;
for i=1:5
acc_test(i)=(accuracy1(i)+accuracy2(i)+accuracy3(i)+accuracy4(i)+accuracy5(i))/double(5);
acc_train(i)=(accuracy1_train(i)+accuracy2_train(i)+accuracy3_train(i)+accuracy4_train(i)+accuracy5_train(i))/double(5);
end
figure 1
plot( X , acc_train);
hold on;
plot(X , acc_test);
legend('Test accuracy','Training accuracy')
xlabel('Training size');
ylabel('Accuracy');
