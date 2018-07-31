%function [prob_mat,y_mat] =traindata(train1,Y_train1,distinct_y,mapObj_vocab,mapObj_class)
function [prob_mat,y_sum]= traindata(train1,Y_train1,distinct_y,mapObj_vocab,mapObj_class)
    prob_mat=zeros(8,size(train1,2));
    y_sum=zeros(8,1);
    for i=1:size(distinct_y,1)
        index = strmatch( char(distinct_y(i,:)),char(Y_train1));
        %display(index);
        temp=train1(index,:);
        prob_mat(i,:)=sum(temp,1);
        total_words=sum(prob_mat(i,:),2);
        prob_mat(i,:)=(prob_mat(i,:)+1)/double(total_words+37053);
        y_sum(i)=size(index,1);
        y_sum(i)=y_sum(i)/double(size(train1,1));
        y_sum(i)=log(y_sum(i));
    end
    prob_mat=log(prob_mat);
end