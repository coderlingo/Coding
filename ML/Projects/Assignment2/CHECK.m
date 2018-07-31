Wg = K'*(a.*Y);

max=0;
min=0;
for i=1:n
    if Y(i)==-1
        if max<Wg(i)
            max=Wg(i);
        end
    end
    if Y(i)==1
        if min >Wg(i)
            min=Wg(i);
        end
    end
end
b=-(max+min)*.5;

% 
% pos=find(Y==1);
% neg=find(Y==-1);
% posWTransposeXg = Wg(pos);
% negWTransposeXg = Wg(neg);
% b = -(max(negWTransposeXg) + min(posWTransposeXg))/2 ;
K_Test = zeros(n,test_n);
for i = 1:n
    for j = 1:test_n
    difference = X(i,:) - test_X(j,:) ;
    t = norm(difference);
    normSquare = t^2 ;
    K_Test(i,j) = exp(cons*normSquare);
    end
end


Wt = K_Test'*(a.*Y);
new_Y = test_Y.*(Wt+ b) ;
correctData = length(find(new_Y > 0));
accuracy = (correctData/test_n)*100;
display(accuracy);

