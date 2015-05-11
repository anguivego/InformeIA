function [W,B]=RLMVR(x,t,M,xtest,ttest,tipofb,lamda)
    N=length(x);
    PHI_train=genBasisFunction(tipofb,x,N,M);
    PHI=genBasisFunction(tipofb,xtest,length(xtest),M);
    W=(lamda*eye(M)+PHI_train'*PHI_train)\PHI_train'*t;
    B=(1/2)*(ttest-PHI*W)'*(ttest-PHI*W)+(lamda/2)*W'*W;
end