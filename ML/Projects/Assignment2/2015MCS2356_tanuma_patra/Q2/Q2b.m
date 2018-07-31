data=load('mnist_all.mat');
train3=data.train3;
train8=data.train8;
test3=data.test3;
test8=data.test8;
S.a=train3;
S.b=train8;
save mnist_bin38.mat S;
[m_3,n_3]=size(train3);
[m_8,n_8]=size(train8);
[test_m_3,test_n_3]=size(test3);
[test_m_8,test_n_8]=size(test8);
input=load('mnist_bin38.mat');

level_1=100;
input_features=784;
theta1=randn(level_1,input_features);
Ones=ones(level_1,1);
theta1=[theta1,Ones];
theta1=theta1.*.001;
theta2=randn(2,level_1);
theta2=[theta2,[1;1]];
theta2=theta2.*.001;
iter=35000;
flag=0;
example=1;
option=1;
m=m_3;
eta=3;
learning_rate=1/sqrt(eta);
example_3=0;
example_8=0;
i=1;
j_theta=100;
while(iter~=0 && flag==0)  
    %to check if digit 3 or 8
    
    %alternating examples
    if option==1
        if example_3==m_3;
            example_3=1;
        else
            example_3=example_3+1;
        end
        test=im2double(train3(example_3,:));
        %test=test./255;
        Y=[1;0];
    else
        if example_8==m_8;
            example_8=1;
        else
            example_8=example_8+1;
        end
        test=im2double(train8(example_8,:));
        %test=test./255;
        Y=[0;1];
    end
    
    
    %forward propagation
    test=[test,1];
    net_1=theta1*test';
    h_theta1=1./(1+exp(-net_1));
    h_theta1_augmented=[h_theta1;1];
   
    net_2=theta2*h_theta1_augmented;
    output=1./(1+exp(-net_2));
    
%     if output(1)>output(2)
%         output(1)=1;
%         output(2)=0;
%     else
%         output(1)=0;
%         output(2)=1;
%     end
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
    
    if diff<.00000000001
        flag=1;
    end
    j_theta=j_theta_new;
    i=i+1;
    learning_rate=1/sqrt(i);
    iter=iter-1;
    %disp(iter);
    theta1=theta1_new;
    theta2=theta2_new;
    option=1-option;
end

