
%reset workspace
clear all
plot_variance = @(x,lower,upper) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color));
data=load('ejemplo_regresion.mat');
xNtot=data.x;
yNtot=data.y;
tNtot=data.t;

Ntot=size(xNtot,1);
N=100;
index=randperm(Ntot);
t=tNtot(index(1:N));
x=xNtot(index(1:N));
tipofb='exp';
M=30;
ttest = tNtot(index(N+1:end));
xtest = xNtot(index(N+1:end));

PHI=genBasisFunction(tipofb,x,N,M);
plot(x, PHI,'+','MarkerSize',2);

[alpha,betae]=findAlphaBeta(PHI,M,N,t);

PHIt = genBasisFunction(tipofb,xNtot,Ntot,M);
SnInv = alpha*(length(x)) + betae*(PHI'*PHI);
Sn = SnInv\eye(M);
mn = betae*(Sn*PHI'*t);
mean_pre=PHIt*mn;
varianza=inv(betae*eye(length(xNtot)))+PHIt*Sn*PHIt';
varianza=diag(sqrt(varianza'));
plot_variance(xNtot',(mean_pre-2*varianza)',(mean_pre+2*varianza)',[1 0.1 0.1]);
set(gca, 'ylim', [-1.5 1.5])

