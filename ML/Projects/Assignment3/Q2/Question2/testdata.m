function [acc,confusion_mat]= testdata(data,Y,Y_index,prob_mat,y_sum,mapObj_class)
    
    matrix_product=data*prob_mat';
    prob_y=repmat(y_sum',size(data,1),1);
    prob_add=matrix_product+prob_y;
    [C,I]=max(prob_add,[],2);
%     index1=find(Y_index==1);
%     index2=find(Y_index==2);
%     index3=find(Y_index==3);
%     index4=find(Y_index==4);
%     index5=find(Y_index==5);
%     index6=find(Y_index==6);
%     index7=find(Y_index==7);
%     index8=find(Y_index==8);
    for i=1:8
        index=find(Y_index==i);
        temp=I(index,:);
        for j=1:8
            a=find(temp==j);
            confusion_mat(i,j)=size(a,1);
        end
    end
    acc=Y_index==I;
    acc=nnz(acc);
    acc=acc/double(size(data,1));
    
end


