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

a=1;
b=1;
c=1;
d=1;
e=1;    
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
% while(i~=0)
%     x=randi(i);
%     display(x);
%     switch choise
%         case 1
%             temp=char(strsplit(data{x,:},'\t'));
%             data1(a,:)=preprocess_matrix(x,:);
%             Y1{a}=temp(1,:);
%             a=a+1;
%         case 2
%             temp=char(strsplit(data{x,:},'\t'));
%             data2(b,:)=preprocess_matrix(x,:);
%             Y2{b}=temp(1,:);
%             b=b+1;
%         case 3                                                                                                                                                                              
%             temp=char(strsplit(data{x,:},'\t'));
%             data3(c,:)=preprocess_matrix(x,:);
%             Y3{c}=temp(1,:);
%             c=c+1;
%         case 4
%             temp=char(strsplit(data{x,:},'\t'));
%             data4(d,:)=preprocess_matrix(x,:);
%             Y4{d}=temp(1,:);
%             d=d+1;
%         case 5
%             temp=char(strsplit(data{x,:},'\t'));
%             data5(e,:)=preprocess_matrix(x,:);
%             Y5{e}=temp(1,:);
%             e=e+1;
%     end
%     data{x,:}=[];
%     preprocess_matrix(x,:)=[];
%     data=data(~cellfun('isempty',data)) ; 
%     i=i-1;
%     choise=choise+1;
%     if choise==6
%         choise=1;
%     end
% end


%train and test data
c_mat=zeros(8,8);
train1=[data1;data2;data3;data4];
a=size(train1,1);
Y_train1=[Y1,Y2,Y3,Y4];
[prob_mat,y_sum]=traindata(train1,Y_train1,distinct_y,mapObj_vocab,mapObj_class);
[acc1,c1_mat]=testdata(data5,Y5,Y_index5,prob_mat,y_sum,mapObj_class);

train2=[data1;data2;data3;data5];
b=size(train2,1);
Y_train2=[Y1,Y2,Y3,Y5];
[prob_mat,y_sum]=traindata(train2,Y_train2,distinct_y,mapObj_vocab,mapObj_class);
[acc2,c2_mat]=testdata(data4,Y4,Y_index4,prob_mat,y_sum,mapObj_class);


train3=[data1;data2;data4;data5];
c=size(train3,1);
Y_train3=[Y1,Y2,Y4,Y5];
[prob_mat,y_sum]=traindata(train3,Y_train3,distinct_y,mapObj_vocab,mapObj_class);
[acc3,c3_mat]=testdata(data3,Y3,Y_index3,prob_mat,y_sum,mapObj_class);


train4=[data1;data3;data4;data5];
d=size(train4,1);
Y_train4=[Y1,Y3,Y4,Y5];
[prob_mat,y_sum]=traindata(train4,Y_train4,distinct_y,mapObj_vocab,mapObj_class);
[acc4,c4_mat]=testdata(data2,Y2,Y_index2,prob_mat,y_sum,mapObj_class);


train5=[data2;data3;data4;data5];
e=size(train5,1);
Y_train5=[Y2,Y3,Y4,Y5];
[prob_mat,y_sum]=traindata(train5,Y_train5,distinct_y,mapObj_vocab,mapObj_class);
[acc5,c5_mat]=testdata(data1,Y1,Y_index1,prob_mat,y_sum,mapObj_class);

combination=5;
flag=1;
acc=zeros(5);
display(acc1);
display(acc2);
display(acc3);
display(acc4);
display(acc5);
avg=acc1+acc2+acc3+acc4+acc5;
avg=avg/5;
display(avg);
c_mat=c1_mat+c2_mat+c3_mat+c4_mat+c5_mat;
c_mat=c_mat/5;
display(c_mat)


