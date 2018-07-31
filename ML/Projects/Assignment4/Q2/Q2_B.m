fid = fopen('train.data');
data2=importdata('test.data');
test_data=data2.data;
%--H B L X F
tline = fgetl(fid);
i=1;
while ischar(tline)
    tline = fgetl(fid);
    data(i,:)=tline;
    i=i+1;
end
fclose(fid);
data=data(1:10000,:);

[row,col]=find(data=='?');
H_indices=row(find(col==1));
B_indices=row(find(col==3));
L_indices=row(find(col==5));
X_indices=row(find(col==7));
F_indices=row(find(col==9));

H_value=zeros(size(H_indices,1),3);
B_value=zeros(size(B_indices,1),3);
L_value=zeros(size(L_indices,1),3);
X_value=zeros(size(X_indices,1),3);
F_value=zeros(size(F_indices,1),3);

%-----data processing
H_data=data(:,1);
B_data=data(:,3);
L_data=data(:,5);
X_data=data(:,7);
F_data=data(:,9);

total_indexes=1:1:10000;

H=zeros(1,2);
B=zeros(2,2);%H,B
L=zeros(2,2);%H,L
X=zeros(2,2);%L,X
F=zeros(2,2,2);%B,L,F

%-----INITIALIZE-----
%For H
H_1=find(H_data=='1');
H_0=find(H_data=='0');
H(1,1)=length(H_0)/double(length(H_data)-length(H_indices));
H(1,2)=length(H_1)/double(length(H_data)-length(H_indices));

%For B
B_0=find(B_data=='0');
B_1=find(B_data=='1');
H_0=find(H_data=='0');
H_1=find(H_data=='1');

B(1,1)=length(intersect(B_0,H_0))/(length(intersect(H_0,B_0))+length(intersect(H_0,B_1)));
B(1,2)=length(intersect(B_1,H_0))/(length(intersect(H_0,B_0))+length(intersect(H_0,B_1)));
B(2,1)=length(intersect(B_0,H_1))/(length(intersect(H_1,B_0))+length(intersect(H_1,B_1)));
B(2,2)=length(intersect(B_1,H_1))/(length(intersect(H_1,B_0))+length(intersect(H_1,B_1)));

%for L
L_0=find(L_data=='0');
L_1=find(L_data=='1');
H_0=find(H_data=='0');
H_1=find(H_data=='1');

L(1,1)=length(intersect(L_0,H_0))/(length(intersect(H_0,L_0))+length(intersect(H_0,L_1)));
L(1,2)=length(intersect(L_1,H_0))/(length(intersect(H_0,L_0))+length(intersect(H_0,L_1)));
L(2,1)=length(intersect(L_0,H_1))/(length(intersect(H_1,L_0))+length(intersect(H_1,L_1)));
L(2,2)=length(intersect(L_1,H_1))/(length(intersect(H_1,L_0))+length(intersect(H_1,L_1)));

%for X
X_0=find(X_data=='0');
X_1=find(X_data=='1');
L_0=find(L_data=='0');
L_1=find(L_data=='1');

X(1,1)=length(intersect(X_0,L_0))/(length(intersect(L_0,X_1))+length(intersect(L_0,X_0)));
X(1,2)=length(intersect(X_1,L_0))/(length(intersect(L_0,X_1))+length(intersect(L_0,X_0)));
X(2,1)=length(intersect(X_0,L_1))/(length(intersect(L_1,X_1))+length(intersect(L_1,X_0)));
X(2,2)=length(intersect(X_1,L_1))/(length(intersect(L_1,X_1))+length(intersect(L_1,X_0)));


%for F
F_0=find(F_data=='0');
F_1=find(F_data=='1');
L_0=find(L_data=='0');
L_1=find(L_data=='1');
B_0=find(B_data=='0');
B_1=find(B_data=='1');

F(1,1,1)=length(intersect(intersect(F_0,L_0),B_0))/(length(intersect(intersect(B_0,L_0),F_0))+length(intersect(intersect(B_0,L_0),F_1)));
F(1,2,1)=length(intersect(intersect(F_0,L_1),B_0))/(length(intersect(intersect(B_0,L_1),F_0))+length(intersect(intersect(B_0,L_1),F_1)));
F(2,1,1)=length(intersect(intersect(F_0,L_0),B_1))/(length(intersect(intersect(B_1,L_0),F_0))+length(intersect(intersect(B_1,L_0),F_1)));
F(2,2,1)=length(intersect(intersect(F_0,L_1),B_1))/(length(intersect(intersect(B_1,L_1),F_0))+length(intersect(intersect(B_1,L_1),F_1)));
F(1,1,2)=length(intersect(intersect(F_1,L_0),B_0))/(length(intersect(intersect(B_0,L_0),F_0))+length(intersect(intersect(B_0,L_0),F_1)));
F(1,2,2)=length(intersect(intersect(F_1,L_1),B_0))/(length(intersect(intersect(B_0,L_1),F_0))+length(intersect(intersect(B_0,L_1),F_1)));
F(2,1,2)=length(intersect(intersect(F_1,L_0),B_1))/(length(intersect(intersect(B_1,L_0),F_0))+length(intersect(intersect(B_1,L_0),F_1)));
F(2,2,2)=length(intersect(intersect(F_1,L_1),B_1))/(length(intersect(intersect(B_1,L_1),F_0))+length(intersect(intersect(B_1,L_1),F_1)));


flag=0;
log_sum_old=0;


while flag==0
    table_index=1;
    %WE NOW START THE E-PHASE
    for i=1:size(data,1)
        D=data(i,:);
        Missing_indices=find(D=='?');
        if size(Missing_indices,2)==0
            H_val=str2num(D(1));
            B_val=str2num(D(3));
            L_val=str2num(D(5));
            X_val=str2num(D(7));
            F_val=str2num(D(9));
            probability_table(table_index)=1;
            processed_data(table_index,:)=[H_val B_val L_val X_val F_val];
            table_index=table_index+1;
            continue;
        end
        if size(Missing_indices)==1
            index=Missing_indices(1);
            %--H=1 B=3 L=5 X=7 F=9
            if index==1
                B_val=str2num(D(3))+1;
                L_val=str2num(D(5))+1;
                X_val=str2num(D(7))+1;
                F_val=str2num(D(9))+1;
                din=(H(1,1)*B(1,B_val)*L(1,L_val)*F(B_val,L_val,F_val)*X(L_val,X_val))+(H(1,2)*B(2,B_val)*L(2,L_val)*F(B_val,L_val,F_val)*X(L_val,X_val));
                probability_table(table_index)=(H(1,1)*B(1,B_val)*L(1,L_val)*F(B_val,L_val,F_val)*X(L_val,X_val))/din;
                processed_data(table_index,:)=[0 B_val-1 L_val-1 X_val-1 F_val-1];
                table_index=table_index+1;
                probability_table(table_index)=(H(1,2)*B(2,B_val)*L(2,L_val)*F(B_val,L_val,F_val)*X(L_val,X_val))/din;
                processed_data(table_index,:)=[1 B_val-1 L_val-1 X_val-1 F_val-1];
                table_index=table_index+1;
            end
            if index==3
                H_val=str2num(D(1))+1;
                L_val=str2num(D(5))+1;
                X_val=str2num(D(7))+1;
                F_val=str2num(D(9))+1;
                din=(H(1,H_val)*B(H_val,1)*L(H_val,L_val)*F(1,L_val,F_val)*X(L_val,X_val))+(H(1,H_val)*B(H_val,2)*L(H_val,L_val)*F(2,L_val,F_val)*X(L_val,X_val));
                probability_table(table_index)=(H(1,H_val)*B(H_val,1)*L(H_val,L_val)*F(1,L_val,F_val)*X(L_val,X_val))/din;
                processed_data(table_index,:)=[H_val-1 0 L_val-1 X_val-1 F_val-1];
                table_index=table_index+1;
                probability_table(table_index)=(H(1,H_val)*B(H_val,2)*L(H_val,L_val)*F(2,L_val,F_val)*X(L_val,X_val))/din;
                processed_data(table_index,:)=[H_val-1 1 L_val-1 X_val-1 F_val-1];
                table_index=table_index+1;
            end
            if index==5
                H_val=str2num(D(1))+1;
                B_val=str2num(D(3))+1;
                X_val=str2num(D(7))+1;
                F_val=str2num(D(9))+1;
                din=(H(1,H_val)*B(H_val,B_val)*L(H_val,1)*F(B_val,1,F_val)*X(1,X_val))+(H(1,H_val)*B(H_val,B_val)*L(H_val,2)*F(B_val,2,F_val)*X(2,X_val));
                probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,1)*F(B_val,1,F_val)*X(1,X_val))/din;
                processed_data(table_index,:)=[H_val-1 B_val-1 0 X_val-1 F_val-1];
                table_index=table_index+1;
                probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,2)*F(B_val,2,F_val)*X(2,X_val))/din;
                processed_data(table_index,:)=[H_val-1 B_val-1 1 X_val-1 F_val-1];
                table_index=table_index+1;    
            end
            if index==7
                H_val=str2num(D(1))+1;
                B_val=str2num(D(3))+1;
                L_val=str2num(D(5))+1;
                F_val=str2num(D(9))+1;
                din=(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,F_val)*X(L_val,1))+(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,F_val)*X(L_val,2));
                probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,F_val)*X(L_val,1))/din;
                processed_data(table_index,:)=[H_val-1 B_val-1 L_val-1 0 F_val-1];
                table_index=1+table_index;
                probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,F_val)*X(L_val,2))/din;
                processed_data(table_index,:)=[H_val-1 B_val-1 L_val-1 1 F_val-1];
                table_index=table_index+1;        
            end
            if index==9
                H_val=str2num(D(1))+1;
                B_val=str2num(D(3))+1;
                L_val=str2num(D(5))+1;
                X_val=str2num(D(7))+1;
                din=(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,1)*X(L_val,X_val))+(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,2)*X(L_val,X_val));
                probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,1)*X(L_val,X_val))/din;
                processed_data(table_index,:)=[H_val-1 B_val-1 L_val-1 X_val-1 0];
                table_index=table_index+1;
                probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,2)*X(L_val,X_val))/din;
                processed_data(table_index,:)=[H_val-1 B_val-1 L_val-1 X_val-1 1];
                table_index=table_index+1;            
            end
        end
        if size(Missing_indices)==2
            if Missing_indices(1)==1
                %--H=1 B=3 L=5 X=7 F=9
                if Missing_indices(2)==3
                    %--H=1 B=3
                    L_val=str2num(D(5))+1;
                    X_val=str2num(D(7))+1;
                    F_val=str2num(D(9))+1;
                    
                    din=(H(1,1)*B(1,1)*L(1,L_val)*F(1,L_val,F_val)*X(L_val,X_val))+(H(1,1)*B(1,2)*L(1,L_val)*F(2,L_val,F_val)*X(L_val,X_val))+(H(1,2)*B(2,1)*L(2,L_val)*F(1,L_val,F_val)*X(L_val,X_val))+(H(1,2)*B(2,2)*L(2,L_val)*F(2,L_val,F_val)*X(L_val,X_val));
                    %00
                    probability_table(table_index)=(H(1,1)*B(1,1)*L(1,L_val)*F(1,L_val,F_val)*X(L_val,X_val))/din;
                    processed_data(table_index,:)=[0 0 L_val X_val F_val];
                    table_index=table_index+1;
                    %01
                    probability_table(table_index)=(H(1,1)*B(1,2)*L(1,L_val)*F(2,L_val,F_val)*X(L_val,X_val))/din;
                    processed_data(table_index,:)=[0 1 L_val X_val F_val];
                    table_index=table_index+1;
                    %10
                    probability_table(table_index)=(H(1,2)*B(2,1)*L(2,L_val)*F(1,L_val,F_val)*X(L_val,X_val))/din;
                    processed_data(table_index,:)=[1 0 L_val X_val F_val];
                    table_index=table_index+1;
                    %11
                    probability_table(table_index)=(H(1,2)*B(2,2)*L(2,L_val)*F(2,L_val,F_val)*X(L_val,X_val))/din;
                    processed_data(table_index,:)=[1 1 L_val X_val F_val];
                    table_index=table_index+1;
                end
                if Missing_indices(2)==5
                    %--H=1 B=3 L=5 X=7 F=9
                    %--H=1 L=5
                    B_val=str2num(D(3))+1;
                    X_val=str2num(D(7))+1;
                    F_val=str2num(D(9))+1;
                    
                    din=(H(1,1)*B(1,B_val)*L(1,1)*F(B_val,1,F_val)*X(1,X_val))+(H(1,1)*B(1,B_val)*L(1,2)*F(B_val,2,F_val)*X(2,X_val))+(H(1,2)*B(2,B_val)*L(2,1)*F(B_val,1,F_val)*X(1,X_val))+(H(1,2)*B(2,B_val)*L(2,2)*F(B_val,2,F_val)*X(2,X_val));
                    %00
                    probability_table(table_index)=(H(1,1)*B(1,B_val)*L(1,1)*F(B_val,1,F_val)*X(1,X_val))/din;
                    processed_data(table_index,:)=[0 B_val 0 X_val F_val];
                    table_index=table_index+1;
                    %01
                    probability_table(table_index)=(H(1,1)*B(1,B_val)*L(1,2)*F(B_val,2,F_val)*X(2,X_val))/din;
                    processed_data(table_index,:)=[0 B_val 1 X_val F_val];
                    table_index=table_index+1;
                    %10
                    probability_table(table_index)=(H(1,2)*B(2,B_val)*L(2,1)*F(B_val,1,F_val)*X(1,X_val))/din;
                    processed_data(table_index,:)=[1 B_val 0 X_val F_val];
                    table_index=table_index+1;
                    %11
                    probability_table(table_index)=(H(1,2)*B(2,B_val)*L(2,2)*F(B_val,2,F_val)*X(2,X_val))/din;
                    processed_data(table_index,:)=[1 B_val 1 X_val F_val];
                    table_index=table_index+1;
                end
                if Missing_indices(2)==7
                    %--H=1 X=7
                    B_val=str2num(D(3))+1;
                    L_val=str2num(D(5))+1;
                    F_val=str2num(D(9))+1;
                    
                    din=(H(1,1)*B(1,B_val)*L(1,L_val)*F(B_val,L_val,F_val)*X(L_val,1))+(H(1,1)*B(1,B_val)*L(1,L_val)*F(B_val,L_val,F_val)*X(L_val,2))+(H(1,2)*B(2,B_val)*L(2,L_val)*F(B_val,L_val,F_val)*X(L_val,1))+(H(1,2)*B(2,B_val)*L(2,L_val)*F(B_val,L_val,F_val)*X(L_val,2));
                    %00
                    probability_table(table_index)=(H(1,1)*B(1,B_val)*L(1,L_val)*F(B_val,L_val,F_val)*X(L_val,1))/din;
                    processed_data(table_index,:)=[0 B_val L_val 0 F_val];
                    table_index=table_index+1;
                    %01
                    probability_table(table_index)=(H(1,1)*B(1,B_val)*L(1,L_val)*F(B_val,L_val,F_val)*X(L_val,2))/din;
                    processed_data(table_index,:)=[0 B_val L_val 1 F_val];
                    table_index=table_index+1;
                    %10
                    probability_table(table_index)=(H(1,2)*B(2,B_val)*L(2,L_val)*F(B_val,L_val,F_val)*X(L_val,1))/din;
                    processed_data(table_index,:)=[1 B_val L_val 0 F_val];
                    table_index=table_index+1;
                    %11
                    probability_table(table_index)=(H(1,2)*B(2,B_val)*L(2,L_val)*F(B_val,L_val,F_val)*X(L_val,2))/din;
                    processed_data(table_index,:)=[1 B_val L_val 1 F_val];
                    table_index=table_index+1;
                end
                if Missing_indices(2)==9
                    %--------------HEEREEEEE
                    %--H=1 B=3 L=5 X=7 F=9
                    %--H=1 F=9
                    B_val=str2num(D(3))+1;
                    X_val=str2num(D(7))+1;
                    L_val=str2num(D(5))+1;
                    
                    din=(H(1,1)*B(1,B_val)*L(1,L_val)*F(B_val,L_val,1)*X(L_val,X_val))+(H(1,1)*B(1,B_val)*L(1,L_val)*F(B_val,L_val,2)*X(L_val,X_val))+(H(1,2)*B(2,B_val)*L(2,L_val)*F(B_val,L_val,1)*X(L_val,X_val))+(H(1,2)*B(2,B_val)*L(2,L_val)*F(B_val,L_val,2)*X(L_val,X_val));
                    %00
                    probability_table(table_index)=(H(1,1)*B(1,B_val)*L(1,L_val)*F(B_val,L_val,1)*X(L_val,X_val))/din;
                    processed_data(table_index,:)=[0 B_val L_val X_val 0];
                    table_index=table_index+1;
                    %01
                    probability_table(table_index)=(H(1,1)*B(1,B_val)*L(1,L_val)*F(B_val,L_val,2)*X(L_val,X_val))/din;
                    processed_data(table_index,:)=[0 B_val L_val X_val 1];
                    table_index=table_index+1;
                    %10
                    probability_table(table_index)=(H(1,1)*B(1,B_val)*L(1,L_val)*F(B_val,L_val,2)*X(L_val,X_val))/din;
                    processed_data(table_index,:)=[1 B_val L_val X_val 0];
                    table_index=table_index+1;
                    %11
                    probability_table(table_index)=(H(1,2)*B(2,B_val)*L(2,L_val)*F(B_val,L_val,2)*X(L_val,X_val))/din;
                    processed_data(table_index,:)=[1 B_val L_val X_val 1];
                    table_index=table_index+1;
                
                end
            end
            if Missing_indices(1)==3
                %--H=1 B=3 L=5 X=7 F=9
                if Missing_indices(2)==5
                    %--B=3 L=5
                    H_val=str2num(D(1))+1;
                    X_val=str2num(D(7))+1;
                    F_val=str2num(D(9))+1;
                    
                    din=(H(1,H_val)*B(H_val,1)*L(H_val,1)*F(1,1,F_val)*X(1,X_val))+(H(1,H_val)*B(H_val,1)*L(H_val,2)*F(1,2,F_val)*X(2,X_val))+(H(1,H_val)*B(H_val,2)*L(H_val,1)*F(2,1,F_val)*X(1,X_val))+(H(1,H_val)*B(H_val,2)*L(H_val,2)*F(2,2,F_val)*X(2,X_val));
                    %00
                    probability_table(table_index)=(H(1,H_val)*B(H_val,1)*L(H_val,1)*F(1,1,F_val)*X(1,X_val))/din;
                    processed_data(table_index,:)=[H_val 0 0 X_val F_val];
                    table_index=table_index+1;
                    %01
                    probability_table(table_index)=(H(1,H_val)*B(H_val,1)*L(H_val,2)*F(1,2,F_val)*X(2,X_val))/din;
                    processed_data(table_index,:)=[H_val 0 1 X_val F_val];
                    table_index=table_index+1;
                    %10
                    probability_table(table_index)=(H(1,H_val)*B(H_val,2)*L(H_val,1)*F(2,1,F_val)*X(1,X_val))/din;
                    processed_data(table_index,:)=[H_val 1 0 X_val F_val];
                    table_index=table_index+1;
                    %11
                    probability_table(table_index)=(H(1,H_val)*B(H_val,2)*L(H_val,2)*F(2,2,F_val)*X(2,X_val))/din;
                    processed_data(table_index,:)=[H_val 1 1 X_val F_val];
                    table_index=table_index+1;
                end
                if Missing_indices(2)==7
                    %--H=1 B=3 L=5 X=7 F=9
                    %--B=3 X=7
                    H_val=str2num(D(1))+1;
                    L_val=str2num(D(5))+1;
                    F_val=str2num(D(9))+1;
                    
                    din=(H(1,H_val)*B(H_val,1)*L(H_val,L_val)*F(1,L_val,F_val)*X(L_val,1))+(H(1,H_val)*B(H_val,1)*L(H_val,L_val)*F(1,L_val,F_val)*X(L_val,2))+(H(1,H_val)*B(H_val,2)*L(H_val,L_val)*F(2,L_val,F_val)*X(L_val,1))+(H(1,H_val)*B(H_val,2)*L(H_val,L_val)*F(2,L_val,F_val)*X(L_val,2));
                    %00
                    probability_table(table_index)=(H(1,H_val)*B(H_val,1)*L(H_val,L_val)*F(1,L_val,F_val)*X(L_val,1))/din;
                    processed_data(table_index,:)=[H_val 0 L_val 0 F_va];
                    table_index=table_index+1;
                    %01
                    probability_table(table_index)=(H(1,H_val)*B(H_val,1)*L(H_val,L_val)*F(1,L_val,F_val)*X(L_val,2))/din;
                    processed_data(table_index,:)=[H_val 0 L_val 1 F_va];
                    table_index=table_index+1;
                    %10
                    probability_table(table_index)=(H(1,H_val)*B(H_val,2)*L(H_val,L_val)*F(2,L_val,F_val)*X(L_val,1))/din;
                    processed_data(table_index,:)=[H_val 1 L_val 0 F_va];
                    table_index=table_index+1;
                    %11
                    probability_table(table_index)=(H(1,H_val)*B(H_val,2)*L(H_val,L_val)*F(2,L_val,F_val)*X(L_val,2))/din;
                    processed_data(table_index,:)=[H_val 1 L_val 1 F_va];
                    table_index=table_index+1;
                
                end
                if Missing_indices(2)==9
                    %--H=1 B=3 L=5 X=7 F=9
                    %--B=3 F=9
                    H_val=str2num(D(1))+1;
                    L_val=str2num(D(5))+1;
                    X_val=str2num(D(7))+1;
                    
                    din=(H(1,H_val)*B(H_val,1)*L(H_val,L_val)*F(1,L_val,1)*X(L_val,X_val))+(H(1,H_val)*B(H_val,1)*L(H_val,L_val)*F(1,L_val,2)*X(L_val,X_val))+(H(1,H_val)*B(H_val,2)*L(H_val,L_val)*F(2,L_val,1)*X(L_val,X_val))+(H(1,H_val)*B(H_val,2)*L(H_val,L_val)*F(2,L_val,2)*X(L_val,X_val));
                    %00
                    probability_table(table_index)=(H(1,H_val)*B(H_val,1)*L(H_val,L_val)*F(1,L_val,1)*X(L_val,X_val))/din;
                    processed_data(table_index,:)=[H_val 0 L_val X_val 0];
                    table_index=table_index+1;
                    %01
                    probability_table(table_index)=(H(1,H_val)*B(H_val,1)*L(H_val,L_val)*F(1,L_val,2)*X(L_val,X_val))/din;
                    processed_data(table_index,:)=[H_val 0 L_val X_val 1];
                    table_index=table_index+1;
                    %10
                    probability_table(table_index)=(H(1,H_val)*B(H_val,2)*L(H_val,L_val)*F(2,L_val,1)*X(L_val,X_val))/din;
                    processed_data(table_index,:)=[H_val 1 L_val X_val 0];
                    table_index=table_index+1;
                    %11
                    probability_table(table_index)=(H(1,H_val)*B(H_val,2)*L(H_val,L_val)*F(2,L_val,2)*X(L_val,X_val))/din;
                    processed_data(table_index,:)=[H_val 1 L_val X_val 1];
                    table_index=table_index+1;
                
                end
            end
            if Missing_indices(1)==5
                %--H=1 B=3 L=5 X=7 F=9
                if Missing_indices(2)==7
                    %--L=5 X=7 
                    H_val=str2num(D(1))+1;
                    B_val=str2num(D(3))+1;
                    F_val=str2num(D(9))+1;
                    
                    din=(H(1,H_val)*B(H_val,B_val)*L(H_val,1)*F(B_val,1,F_val)*X(1,1))+(H(1,H_val)*B(H_val,B_val)*L(H_val,1)*F(B_val,1,F_val)*X(1,2))+(H(1,H_val)*B(H_val,B_val)*L(H_val,2)*F(B_val,2,F_val)*X(2,1))+(H(1,H_val)*B(H_val,B_val)*L(H_val,2)*F(B_val,2,F_val)*X(2,2));
                    %00
                    probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,1)*F(B_val,1,F_val)*X(1,1))/din;
                    processed_data(table_index,:)=[H_val B_val 0 0 F_val];
                    table_index=table_index+1;
                    %01
                    probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,1)*F(B_val,1,F_val)*X(1,2))/din;
                    processed_data(table_index,:)=[H_val B_val 0 1 F_val];
                    table_index=table_index+1;
                    %10
                    probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,2)*F(B_val,2,F_val)*X(2,1))/din;
                    processed_data(table_index,:)=[H_val B_val 1 0 F_val];
                    table_index=table_index+1;
                    %11
                    probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,2)*F(B_val,2,F_val)*X(2,2))/din;
                    processed_data(table_index,:)=[H_val B_val 1 1 F_val];
                    table_index=table_index+1;
                
                end
                if Missing_indices(2)==9
                    %--H=1 B=3 L=5 X=7 F=9
                    %--L=5 F=9
                    H_val=str2num(D(1))+1;
                    B_val=str2num(D(3))+1;
                    X_val=str2num(D(7))+1;
                    
                    din=(H(1,H_val)*B(H_val,B_val)*L(H_val,1)*F(B_val,1,1)*X(1,X_val))+(H(1,H_val)*B(H_val,B_val)*L(H_val,1)*F(B_val,1,2)*X(1,X_val))+(H(1,H_val)*B(H_val,B_val)*L(H_val,2)*F(B_val,2,1)*X(2,X_val))+(H(1,H_val)*B(H_val,B_val)*L(H_val,2)*F(B_val,2,2)*X(2,X_val));
                    %00
                    probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,1)*F(B_val,1,1)*X(1,X_val))/din;
                    processed_data(table_index,:)=[H_val B_val 0 X_val 0];
                    table_index=table_index+1;
                    %01
                    probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,1)*F(B_val,1,2)*X(1,X_val))/din;
                    processed_data(table_index,:)=[H_val B_val 0 X_val 1];
                    table_index=table_index+1;
                    %10
                    probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,2)*F(B_val,2,1)*X(2,X_val))/din;
                    processed_data(table_index,:)=[H_val B_val 1 X_val 0];
                    table_index=table_index+1;
                    %11
                    probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,2)*F(B_val,2,2)*X(2,X_val))/din;
                    processed_data(table_index,:)=[H_val B_val 1 X_val 1];
                    table_index=table_index+1;
                
                end
            end
            if Missing_indices(1)==7
                if Missing_indices(2)==9
                    %--H=1 B=3 L=5 X=7 F=9
                    %--X=7 F=9
                    H_val=str2num(D(1))+1;
                    B_val=str2num(D(3))+1;
                    L_val=str2num(D(5))+1;
                    
                    din=(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,1)*X(L_val,1))+(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,2)*X(L_val,1))+(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,1)*X(L_val,2))+(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,2)*X(L_val,2));
                    %00
                    probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,1)*X(L_val,1))/din;
                    processed_data(table_index,:)=[H_val B_val L_val 0 0];
                    table_index=table_index+1;
                    %01
                    probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,2)*X(L_val,1))/din;
                    processed_data(table_index,:)=[H_val B_val L_val 0 1];
                    table_index=table_index+1;
                    %10
                    probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,1)*X(L_val,2))/din;
                    processed_data(table_index,:)=[H_val B_val L_val 1 0];
                    table_index=table_index+1;
                    %11
                    probability_table(table_index)=(H(1,H_val)*B(H_val,B_val)*L(H_val,L_val)*F(B_val,L_val,2)*X(L_val,2))/din;
                    processed_data(table_index,:)=[H_val B_val L_val 1 1];
                    table_index=table_index+1;
                    
                end
            end
        end
    end
    
    %NOW FOR THE M STEP
    %--H
    indices=find(processed_data(:,1)==0);
    prob_sum=sum(probability_table(indices));
    H(1,1)=prob_sum/sum(probability_table(:));
    indices=find(processed_data(:,1)==1);
    prob_sum=sum(probability_table(indices));
    H(1,2)=prob_sum/sum(probability_table(:));
    
    %--B
    %--H=1 B=2 L=3 X=4 F=5
    indices=intersect(find(processed_data(:,1)==0),find(processed_data(:,2)==0));
    prob_sum=sum(probability_table(indices));
    indices=find(processed_data(:,1)==0);
    B(1,1)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(find(processed_data(:,1)==0),find(processed_data(:,2)==1));
    prob_sum=sum(probability_table(indices));
    indices=find(processed_data(:,1)==0);
    B(1,2)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(find(processed_data(:,1)==1),find(processed_data(:,2)==0));
    prob_sum=sum(probability_table(indices));
    indices=find(processed_data(:,1)==1);
    B(2,1)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(find(processed_data(:,1)==1),find(processed_data(:,2)==1));
    prob_sum=sum(probability_table(indices));
    indices=find(processed_data(:,1)==1);
    B(2,2)=prob_sum/sum(probability_table(indices));
    
    
    %--L
    
    indices=intersect(find(processed_data(:,1)==0),find(processed_data(:,3)==0));
    prob_sum=sum(probability_table(indices));
    indices=find(processed_data(:,1)==0);
    L(1,1)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(find(processed_data(:,1)==0),find(processed_data(:,3)==1));
    prob_sum=sum(probability_table(indices));
    indices=find(processed_data(:,1)==0);
    L(1,2)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(find(processed_data(:,1)==1),find(processed_data(:,3)==0));
    prob_sum=sum(probability_table(indices));
    indices=find(processed_data(:,1)==1);
    L(2,1)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(find(processed_data(:,1)==1),find(processed_data(:,3)==1));
    prob_sum=sum(probability_table(indices));
    indices=find(processed_data(:,1)==1);
    L(2,2)=prob_sum/sum(probability_table(indices));
    
    %--X
    %--DEPENDS UPON L
    %--H=1 B=2 L=3 X=4 F=5
    indices=intersect(find(processed_data(:,4)==0),find(processed_data(:,3)==0));
    prob_sum=sum(probability_table(indices));
    indices=find(processed_data(:,3)==0);
    X(1,1)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(find(processed_data(:,4)==0),find(processed_data(:,3)==1));
    prob_sum=sum(probability_table(indices));
    indices=find(processed_data(:,3)==1);
    X(2,1)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(find(processed_data(:,4)==1),find(processed_data(:,3)==0));
    prob_sum=sum(probability_table(indices));
    indices=find(processed_data(:,3)==0);
    X(1,2)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(find(processed_data(:,4)==1),find(processed_data(:,3)==1));
    prob_sum=sum(probability_table(indices));
    indices=find(processed_data(:,3)==1);
    X(2,2)=prob_sum/sum(probability_table(indices));
    
    %--F
    %--DEPENDS UPON B,L
    %--H=1 B=2 L=3 X=4 F=5
    
    indices=intersect(intersect(find(processed_data(:,2)==0),find(processed_data(:,3)==0)),find(processed_data(:,5)==0));
    prob_sum=sum(probability_table(indices));
    indices=intersect(find(processed_data(:,2)==0),find(processed_data(:,3)==0));
    F(1,1,1)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(intersect(find(processed_data(:,2)==0),find(processed_data(:,3)==1)),find(processed_data(:,5)==0));
    prob_sum=sum(probability_table(indices));
    indices=intersect(find(processed_data(:,2)==0),find(processed_data(:,3)==1));
    F(1,2,1)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(intersect(find(processed_data(:,2)==1),find(processed_data(:,3)==0)),find(processed_data(:,5)==0));
    prob_sum=sum(probability_table(indices));
    indices=intersect(find(processed_data(:,2)==1),find(processed_data(:,3)==0));
    F(2,1,1)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(intersect(find(processed_data(:,2)==1),find(processed_data(:,3)==1)),find(processed_data(:,5)==0));
    prob_sum=sum(probability_table(indices));
    indices=intersect(find(processed_data(:,2)==1),find(processed_data(:,3)==1));
    F(2,2,1)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(intersect(find(processed_data(:,2)==0),find(processed_data(:,3)==0)),find(processed_data(:,5)==1));
    prob_sum=sum(probability_table(indices));
    indices=intersect(find(processed_data(:,2)==0),find(processed_data(:,3)==0));
    F(1,1,2)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(intersect(find(processed_data(:,2)==0),find(processed_data(:,3)==1)),find(processed_data(:,5)==1));
    prob_sum=sum(probability_table(indices));
    indices=intersect(find(processed_data(:,2)==0),find(processed_data(:,3)==1));
    F(1,2,2)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(intersect(find(processed_data(:,2)==1),find(processed_data(:,3)==0)),find(processed_data(:,5)==1));
    prob_sum=sum(probability_table(indices));
    indices=intersect(find(processed_data(:,2)==1),find(processed_data(:,3)==0));
    F(2,1,2)=prob_sum/sum(probability_table(indices));
    
    indices=intersect(intersect(find(processed_data(:,2)==1),find(processed_data(:,3)==1)),find(processed_data(:,5)==1));
    prob_sum=sum(probability_table(indices));
    indices=intersect(find(processed_data(:,2)==1),find(processed_data(:,3)==1));
    F(2,2,2)=prob_sum/sum(probability_table(indices));
    
    
    %------LOG LIKELY HOOD
    log_sum=0;
    
    for i=1:size(processed_data,1)
       D=processed_data(i,:);
       
       for j=1:size(D,2)

          if j==1
              %H
              H_val=D(j)+1;
              log_sum=log_sum+log(H(H_val));
          end
          if j==2
              %B
              B_val=D(j)+1;
              H_val=D(1)+1;
              log_sum=log_sum+log(B(H_val,B_val));
          end
          if j==3
              %L
              L_val=D(j)+1;
              H_val=D(1)+1;
              log_sum=log_sum+log(L(H_val,L_val));
          end
          if j==4
              %X
              X_val=D(j)+1;
              L_val=D(3)+1;
              log_sum=log_sum+log(X(L_val,X_val));
          end
          if j==5
              %F
              F_val=D(j)+1;
              B_val=D(2)+1;
              L_val=D(3)+1;
              log_sum=log_sum+log(F(B_val,L_val,F_val));
          end
       end
    end  
    
    if abs(log_sum-log_sum_old)<=.0000001
        flag=1;
    end
    display(log_sum)
    log_sum_old=log_sum;
    
end
log_sum=0;
for i=1:size(test_data,1)
       D=test_data(i,:);
       
       for j=1:size(D,2)

          if j==1
              %H
              H_val=D(j)+1;
              log_sum=log_sum+log(H(H_val));
          end
          if j==2
              %B
              B_val=D(j)+1;
              H_val=D(1)+1;
              log_sum=log_sum+log(B(H_val,B_val));
          end
          if j==3
              %L
              L_val=D(j)+1;
              H_val=D(1)+1;
              log_sum=log_sum+log(L(H_val,L_val));
          end
          if j==4
              %X
              X_val=D(j)+1;
              L_val=D(3)+1;
              log_sum=log_sum+log(X(L_val,X_val));
          end
          if j==5
              %F
              F_val=D(j)+1;
              B_val=D(2)+1;
              L_val=D(3)+1;
              log_sum=log_sum+log(F(B_val,L_val,F_val));
          end
       end
end  
 display(log_sum);