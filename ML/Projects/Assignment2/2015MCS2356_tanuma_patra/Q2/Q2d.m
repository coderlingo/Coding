data=load('mnist_all.mat');
train0=data.train0;
train1=data.train1;
train2=data.train2;
train3=data.train3;
train4=data.train4;
train5=data.train5;
train6=data.train6;
train7=data.train7;
train8=data.train8;
train9=data.train9;
test0=data.test0;
test1=data.test1;
test2=data.test2;
test3=data.test3;
test4=data.test4;
test5=data.test5;
test6=data.test6;
test7=data.test7;
test8=data.test8;
test9=data.test9;

[m_0,n_0]=size(train0);
[m_1,n_1]=size(train1);
[m_2,n_2]=size(train2);
[m_3,n_3]=size(train3);
[m_4,n_4]=size(train4);
[m_5,n_5]=size(train5);
[m_6,n_6]=size(train6);
[m_7,n_7]=size(train7);
[m_8,n_8]=size(train8);
[m_9,n_9]=size(train9);
[test_m_0,test_n_0]=size(test0);
[test_m_1,test_n_1]=size(test1);
[test_m_2,test_n_2]=size(test2);
[test_m_3,test_n_3]=size(test3);
[test_m_4,test_n_4]=size(test4);
[test_m_5,test_n_5]=size(test5);
[test_m_6,test_n_6]=size(test6);
[test_m_7,test_n_7]=size(test7);
[test_m_8,test_n_8]=size(test8);
[test_m_9,test_n_9]=size(test9);


level_1=100;
input_features=784;
theta1=randn(level_1,input_features);
Ones=ones(level_1,1);
theta1=[theta1,Ones];
theta1=theta1.*.001;
theta2=randn(10,level_1);
theta2=[theta2,[1;1;1;1;1;1;1;1;1;1]];
theta2=theta2.*.001;
iter=500000;
flag=0;
example=1;
option=1;
m=m_0;
eta=3;
learning_rate=1/sqrt(eta);
example_0=0;
example_1=0;
example_2=0;
example_3=0;
example_4=0;
example_5=0;
example_6=0;
example_7=0;
example_8=0;
example_9=0;
i=1;
j_theta=100;
while(iter~=0 && flag==0)  
    %to check if digit 3 or 8
    switch option
        case 0
            if example_0==m_0;
                example_0=1;
            else
                example_0=example_0+1;
            end
            test=im2double(train0(example_0,:));
            %test=test./255;
            Y=[1;0;0;0;0;0;0;0;0;0];
        case 1
            if example_1==m_1;
                example_1=1;
            else
                example_1=example_1+1;
            end
            test=im2double(train1(example_1,:));
            %test=test./255;
            Y=[0;1;0;0;0;0;0;0;0;0];
        case 2
            if example_2==m_2;
                example_2=1;
            else
                example_2=example_2+1;
            end
            test=im2double(train2(example_2,:));
            %test=test./255;
            Y=[0;0;1;0;0;0;0;0;0;0];    
        case 3
            if example_3==m_3;
                example_3=1;
            else
                example_3=example_3+1;
            end
            test=im2double(train3(example_3,:));
            %test=test./255;
            Y=[0;0;0;1;0;0;0;0;0;0];
        case 4
            if example_4==m_4;
                example_4=1;
            else
                example_4=example_4+1;
            end
            test=im2double(train4(example_4,:));
            %test=test./255;
            Y=[0;0;0;0;1;0;0;0;0;0];
        case 5
            if example_5==m_5;
                example_5=1;
            else
                example_5=example_5+1;
            end
            test=im2double(train5(example_5,:));
            %test=test./255;
            Y=[0;0;0;0;0;1;0;0;0;0];
        case 6
            if example_6==m_6;
                example_6=1;
            else
                example_6=example_6+1;
            end
            test=im2double(train6(example_6,:));
            %test=test./255;
            Y=[0;0;0;0;0;0;1;0;0;0];
        case 7
            if example_7==m_7;
                example_7=1;
            else
                example_7=example_7+1;
            end
            test=im2double(train7(example_7,:));
            %test=test./255;
            Y=[0;0;0;0;0;0;0;1;0;0];    
        case 8
            if example_8==m_8;
                example_8=1;
            else
                example_8=example_8+1;
            end
            test=im2double(train8(example_8,:));
            %test=test./255;
            Y=[0;0;0;0;0;0;0;0;1;0];
        case 9
            if example_9==m_9;
                example_9=1;
            else
                example_9=example_9+1;
            end
            test=im2double(train9(example_9,:));
            %test=test./255;
            Y=[0;0;0;0;0;0;0;0;0;1];
   
    end
    
    
    %forward propagation
    test=[test,1];
    net_1=theta1*test';
    h_theta1=1./(1+exp(-net_1));
    h_theta1_augmented=[h_theta1;1];
   
    net_2=theta2*h_theta1_augmented;
    output=1./(1+exp(-net_2));
 
    display(output);
    %~~Back propagation
    %del last
    del_last=output.*(1-output).*(Y-output);%last layer del 3=1,8=0
    
    %~derivative for hidden
    gradient_2=del_last*h_theta1_augmented';%2,101
    theta2_new=theta2+learning_rate*gradient_2;%2,101
    
    
    %~del middle
    del_middle=(theta2(:,1:end-1)'*del_last).*h_theta1.*(1-h_theta1);
    
    %derivative of input
    gradient_1=del_middle*test;
    theta1_new=theta1+learning_rate*gradient_1;
    %j_theta calculation
    j_theta_new=(output-Y)'*(output-Y);
    diff=abs(j_theta_new-j_theta);
    
    if diff<.00000001
        flag=1;
    end
    j_theta=j_theta_new;
    i=i+1;
    learning_rate=1/sqrt(i);
    iter=iter-1;
    %disp(iter);
    theta1=theta1_new;
    theta2=theta2_new;
    option=option+1;
    if option == 10
        option=0;
    end
end
display(i);
