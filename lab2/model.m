function [mean_pre,varianza]=model(PHI,N,Sn,mn,betae)
    mean_pre=PHI*mn;
    varianza=inv(betae*eye(N))+PHI*Sn*PHI';
    varianza=diag(sqrt(varianza'));
end