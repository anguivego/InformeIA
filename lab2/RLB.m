function [Sn,mn,E,alpha,betae]=RLB(x,t,M,xtest,ttest,tipofb)
    N=length(x);
    PHI=genBasisFunction(tipofb,x,N,M);
    [alpha,betae]=findAlphaBeta(PHI,M,N,t);
    SnInv = alpha*(length(x)) + betae*(PHI'*PHI);
    Sn = SnInv\eye(M);
    mn = betae*(Sn*PHI'*t);
    PHI_test= genBasisFunction(tipofb,xtest,length(xtest),M);
    E=(betae/2)*(ttest-PHI_test*mn)'*(ttest-PHI_test*mn)+(alpha/2)*(mn'*mn);

end