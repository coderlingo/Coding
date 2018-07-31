

    n=size(vocab,1);
    
    param=zeros(size(distinct_y,1),n);
    den=zeros(8,1);
    for i=1:size(data,1)
        data_words=char(strsplit(data{i,:},' '));
        for j=1:num_of_words(i)
            display('train')
            temp=cellstr(data_words(j,:));
            %display(j);
            %display(i);
            %display(temp{1,:});
            if(~isempty(temp{1,:}))
                n = mapObj_vocab(temp{1,:});
            end
            temp=cellstr(Y{:,i});
            %display(temp);
            m = mapObj_class(temp{1,:});
            param(m,n)=param(m,n)+1;
        end
        temp=cellstr(Y{:,i});
        m = mapObj_class(temp{1,:});
        den(m)=num_of_words(i);
        
    end
    for i=1:8
        param(i,:)=(param(i,:)+1)/(den(i)+size(vocab,1));
    end
end