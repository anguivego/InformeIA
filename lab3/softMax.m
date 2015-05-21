function [W,J]=softMax(X,NC,iter,alpha)
    J=ones(iter,1);
    W=rand(NC,size(X,2)-1);
    M=size(X,1);
    for i=1:iter
        C=exp(W(1,:)*X(:,1:end-1)')+exp(W(2,:)*X(:,1:end-1)')+exp(W(3,:)*X(:,1:end-1)');
        W(1,:)=W(1,:)+((alpha/M)*X(:,1:end-1)'*((X(:,6)==1)'-exp(W(1,:)*X(:,1:end-1)')./C)')';
        W(2,:)=W(2,:)+((alpha/M)*X(:,1:end-1)'*((X(:,6)==2)'-exp(W(2,:)*X(:,1:end-1)')./C)')';
        W(3,:)=W(3,:)+((alpha/M)*X(:,1:end-1)'*((X(:,6)==3)'-exp(W(3,:)*X(:,1:end-1)')./C)')';
        J(i)=-(1/M)*sum(((X(:,6)==1)'*log(exp(W(1,:)*X(:,1:end-1)')./C)')+((X(:,6)==2)'*log(exp(W(2,:)*X(:,1:end-1)')./C)')+...
            ((X(:,6)==3)'*log(exp(W(3,:)*X(:,1:end-1)')./C)'));
    end

end