function [preprocess_matrix,Y,Y_index]= pre_process(m,data,vocab_size,mapObj_vocab,mapObj_class)
    preprocess_matrix=zeros(m,vocab_size);
    for i=1:size(data,1)
            temp=char(strsplit(data{i,:},'\t'));
            data_words=strsplit(temp(2,:),' ');
            Y{i}=temp(1,:);
            t=cellstr(Y{:,i});
            m = mapObj_class(t{1,:});
            Y_index(i,1)=m;
%           m = mapObj_class(temp(1,:));
            %Y{i}(1)=char(data_words(i,:));
            for j=1:size(data_words,2)
                display('here');
                temp1=cellstr(data_words(:,j));
                if(~isempty(temp1{1,:}))
                    %display(temp1);
                    n = mapObj_vocab(temp1{1,:});
                end
                preprocess_matrix(i,n)=preprocess_matrix(i,n)+1;
            end
    end
end

