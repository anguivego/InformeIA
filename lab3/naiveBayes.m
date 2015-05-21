function [W1,W10,W2,W20,W3,W30]=naiveBayes(X)
    
    X1 = X(X(:,end)==1,1:end-1);
    X2 = X(X(:,end)==2,1:end-1);
    X3 = X(X(:,end)==3,1:end-1);
    N1=length(X1);
    N2=length(X2);
    N3=length(X3);
    N_train=N1;
    
    m1=(sum(X1)/N1)';
    m2=(sum(X2)/N2)';
    m3=(sum(X3)/N3)';
    
    p1=N1/(N1+N2+N3);
    p2=N2/(N1+N2+N3);
    p3=N3/(N1+N2+N3);
    Sw1=0;
    Sw2=0;
    Sw3=0;
    for i=1:N1
    Sw1=Sw1+(X1(i,:)'-m1)*(X1(i,:)'-m1)';
    Sw2=Sw2+(X2(i,:)'-m2)*(X2(i,:)'-m2)';
    Sw3=Sw3+(X3(i,:)'-m3)*(X3(i,:)'-m3)';
    end
    S1=Sw1/N1;
    S2=Sw2/N2;
    S3=Sw3/N3;

    Sigma=(N1/N_train)*S1+(N2/N_train)*S2+(N3/N_train)*S3;

    W1=Sigma\m1;
    W10=(-0.5*m1'*(Sigma\m1))+log(p1);

    W2=Sigma\m2;
    W20=(-0.5*m2'*(Sigma\m2))+log(p2);

    W3=Sigma\m3;
    W30=(-0.5*m3'*(Sigma\m3))+log(p3); 
end