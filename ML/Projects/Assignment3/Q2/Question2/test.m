function count = test(data,param, y,Y,num,distinct_y,mapObj_vocab,mapObj_class)
    count=0;
    for i=1:size(data,1)
        data_words=char(strsplit(data{i,:},' '));
        mat=zeros(8,size(data_words,1));
        for j=1:size(data_words,1)
            temp=cellstr(data_words(j,:));
            if(~isempty(temp{1,:}))
                %display(temp);
                n = mapObj_vocab(temp{1,:});
            end
            for z=1:8
            mat(z,j)=log(param(z,n));
            end
        end
        sum=zeros(8);
        for j=1:8
            temp=mat(j,:);
            sum1=0;  
            for v=1:size(temp,2)
               sum1= sum1+temp(v);
            end
            sum(j)=sum1+log(y(j));
        end
        [maximun,I]=max(sum);  
        temp=cellstr(Y{:,i});
        m = mapObj_class(temp{1,:});
        if(I==m)
            count=count+1;
        end
    end
    count=count/size(data,1);
end