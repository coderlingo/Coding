imported_data=importdata('digitdata.txt');
data=imported_data.data;
A=3:5:783;
B=zeros(1000,784);
for i=1:1000
   B(i,A)=data(i,:);
end
input=csvread('input.csv');
DIGIT=zeros(28,28);
subplot(1,1,1);
for i=1:28
    DIGIT(i,:)=B(input(1),(i-1)*28+1:i*28);
end
imshow(DIGIT);


