function [W,B]=RLMV(x,t,M,xtest,ttest,tipofb)
    N=length(x);
    PHI_train=genBasisFunction(tipofb,x,N,M);
    PHI=genBasisFunction(tipofb,xtest,length(xtest),M);
    W=(PHI_train'*PHI_train)\PHI_train'*t;
    B=(1/size(PHI,1))*(ttest-PHI*W)'*(ttest-PHI*W);
end