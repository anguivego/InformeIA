close all
clear all
data=load('iris.data');
K=max(data(:,end));
T=zeros(length(data),K);
%data=[ones(length(data),1) data];
X=[ones(length(data),1) data(:,1:end-1)];

X1 = X(data(:,end)==1,:);
X2 = X(data(:,end)==2,:);
X3 = X(data(:,end)==3,:);
NtotC = size(X1, 1); 
N=NtotC/5;

index=randperm(NtotC);



for i=1:length(T)
    T(i,data(i,end))=1;
end


T1=T(1:NtotC,:);
T2=T(NtotC+1:2*NtotC,:);
T3=T((2*NtotC)+1:3*NtotC,:);
acc=[];
for i=1:5
    XP=[X1(index(1:4*N),:);X2(index(1:4*N),:);X3(index(1:4*N),:)];
    TP=[T1(index(1:4*N),:);T2(index(1:4*N),:);T3(index(1:4*N),:)];
    Xt=[X1(index(4*N+1:end),:);X2(index(4*N+1:end),:);X3(index(4*N+1:end),:)];
    Tt=[T1(index(4*N+1:end),:);T2(index(4*N+1:end),:);T3(index(4*N+1:end),:)];
    [W,squareError]=minSqrt(XP,TP);
    acc=[acc acurracy(Xt*W,Tt)];
    X1=[X1(index(4*N+1:end),:); X1(index(1:4*N),:)];
    X2=[X2(index(4*N+1:end),:); X2(index(1:4*N),:)];
    X3=[X3(index(4*N+1:end),:); X3(index(1:4*N),:)];
    
    T1=[T1(index(4*N+1:end),:); T1(index(1:4*N),:)];
    T2=[T2(index(4*N+1:end),:); T2(index(1:4*N),:)];
    T3=[T3(index(4*N+1:end),:); T3(index(1:4*N),:)];
end



