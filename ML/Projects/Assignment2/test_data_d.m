%test
flag=0;

result=0;
iter=1;

m=test_m_0;
example=1;
while m~=0
   Y=[1,0,0,0,0,0,0,0,0,0];
   test=im2double(test0(example,:));
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
   [M,I]=max(output);
   output=zeros(10,1);
   output(I,1)=1;
    
   if output(1)==Y
       result=result+1;
   end
   example=example+1;
   m=m-1;
end

m=test_m_8;
example=1;
while m~=0
   Y=[0,0,0,0,0,0,0,0,1,0];
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
   [M,I]=max(output);
   output=zeros(10,1);
   output(I,1)=1;
    
   if output(1)==Y
       result=result+1;
   end
   example=example+1;
   m=m-1;
end
m=test_m_1;
example=1;
while m~=0
   Y=[0,1,0,0,0,0,0,0,0,0];
   test=im2double(test1(example,:));
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


m=test_m_2;
example=1;
while m~=0
   Y=[0,0,1,0,0,0,0,0,0,0];
   test=im2double(test2(example,:));
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
   [M,I]=max(output);
   output=zeros(10,1);
   output(I,1)=1;
    
   if output(1)==Y
       result=result+1;
   end
   example=example+1;
   m=m-1;
end



m=test_m_3;
example=1;
while m~=0
   Y=[0,0,0,1,0,0,0,0,0,0];
   test=im2double(test3(example,:));
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
   [M,I]=max(output);
   output=zeros(10,1);
   output(I,1)=1;
    
   if output(1)==Y
       result=result+1;
   end
   example=example+1;
   m=m-1;
end


m=test_m_4;
example=1;
while m~=0
   Y=[0,0,0,0,1,0,0,0,0,0];
   test=im2double(test4(example,:));
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
   [M,I]=max(output);
   output=zeros(10,1);
   output(I,1)=1;
    
   if output(1)==Y
       result=result+1;
   end
   example=example+1;
   m=m-1;
end



m=test_m_5;
example=1;
while m~=0
   Y=[0,0,0,0,0,1,0,0,0,0];
   test=im2double(test5(example,:));
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
   [M,I]=max(output);
   output=zeros(10,1);
   output(I,1)=1;
    
   if output(1)==Y
       result=result+1;
   end
   example=example+1;
   m=m-1;
end


m=test_m_6;
example=1;
while m~=0
   Y=[0,0,0,0,0,0,1,0,0,0];
   test=im2double(test6(example,:));
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
   [M,I]=max(output);
   output=zeros(10,1);
   output(I,1)=1;
    
   if output(1)==Y
       result=result+1;
   end
   example=example+1;
   m=m-1;
end


m=test_m_7;
example=1;
while m~=0
   Y=[0,0,0,0,0,0,0,1,0,0];
   test=im2double(test7(example,:));
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
   [M,I]=max(output);
   output=zeros(10,1);
   output(I,1)=1;
    
   if output(1)==Y
       result=result+1;
   end
   example=example+1;
   m=m-1;
end


m=test_m_9;
example=1;
while m~=0
   Y=[0,0,0,0,0,0,0,0,0,1];
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
   [M,I]=max(output);
   output=zeros(10,1);
   output(I,1)=1;
    
   if output(1)==Y
       result=result+1;
   end
   example=example+1;
   m=m-1;
end

display('Acuracy');
disp(result/(test_m_8+test_m_3));
