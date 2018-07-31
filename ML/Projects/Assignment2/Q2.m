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
input=csvread('input.csv');
Zero=zeros(28,28);
One=zeros(28,28);
Two=zeros(28,28);
Three=zeros(28,28);
Four=zeros(28,28);
Five=zeros(28,28);
Six=zeros(28,28);
Seven=zeros(28,28);
Eight=zeros(28,28);
Nine=zeros(28,28);
subplot(10,1,1);
for i=1:28
    Zero(i,:)=train0(input(1),(i-1)*28+1:i*28);
end
imshow(Zero);
for i=1:28
    One(i,:)=train1(input(1),(i-1)*28+1:i*28);
end
subplot(10,1,2);
imshow(One);
for i=1:28
    Two(i,:)=train2(input(1),(i-1)*28+1:i*28);
end
subplot(10,1,3);
imshow(Two);
for i=1:28
    Three(i,:)=train3(input(1),(i-1)*28+1:i*28);
end
subplot(10,1,4);
imshow(Three);
for i=1:28
    Four(i,:)=train4(input(1),(i-1)*28+1:i*28);
end
subplot(10,1,5);
imshow(Four);
for i=1:28
    Five(i,:)=train5(input(1),(i-1)*28+1:i*28);
end
subplot(10,1,6);
imshow(Five);
for i=1:28
    Six(i,:)=train6(input(1),(i-1)*28+1:i*28);
end
subplot(10,1,7);
imshow(Six);
for i=1:28
    Seven(i,:)=train7(input(1),(i-1)*28+1:i*28);
end
subplot(10,1,8);
imshow(Seven);
for i=1:28
    Eight(i,:)=train8(input(1),(i-1)*28+1:i*28);
end
subplot(10,1,9);
imshow(Eight);
for i=1:28
    Nine(i,:)=train9(input(1),(i-1)*28+1:i*28);
end
subplot(10,1,10);
imshow(Nine);