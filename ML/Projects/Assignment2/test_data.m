%test
flag=0;
m=test_m_3;
example=1;
result=0;
iter=1;
while m~=0
   Y=[1,0];
   test=im2double(test3(example,:));
  % test=test./255;
   
    test=[test,1];
    net_1=theta1*test';
    h_theta1=1./(1+exp(-net_1));
    h_theta1_augmented=[h_theta1;1];
    net_2=theta2*h_theta1_augmented;
    output=1./(1+exp(-net_2));
     
   
    if output(1)>output(2)
        output(1)=1;
        output(2)=0;
    else
        output(1)=0;
        output(2)=1;
    end
    if output==Y'
        result=result+1;
    end
    example=example+1;
    m=m-1;
end

display('Acuracy');
disp(result/(test_m_3));
m=test_m_8;
example=1;

iter=1;
while m~=0
   Y=[0,1];
   test=im2double(test8(example,:));
  
   
   
    test=[test,1];
    net_1=theta1*test';
    h_theta1=1./(1+exp(-net_1));
    h_theta1_augmented=[h_theta1;1];
    
   % h_theta1_augmented=repmat(h_theta1_augmented,1,2);
   % theta2=[theta2,[1;1]];
    %h_theta1=repmat(h_theta1,2);
    net_2=theta2*h_theta1_augmented;
    output=1./(1+exp(-net_2));
    display(output);
   
   

    if output(1)>output(2)
        output(1)=1;
        output(2)=0;
    else
        output(1)=0;
        output(2)=1;
    end
    if output(1)==Y(1) && output(2)==Y(2)
        result=result+1;
    end
    example=example+1;
    m=m-1;
end
display('Acuracy');
disp(result/(test_m_8+test_m_3));
