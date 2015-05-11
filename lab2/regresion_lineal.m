close all
clear all
s = RandStream.create('mt19937ar','seed',1e1);
%RandStream.setDefaultStream(s); % Version MATLAB 2010
RandStream.setGlobalStream(s); % Version MATLAB 2013

data=load('ejemplo_regresion.mat');
xNtot=data.x;
yNtot=data.y;
tNtot=data.t;


tipofb='tan';

Ntot=size(xNtot,1);
N=Ntot/5;
index=randperm(Ntot);

B_test=[];
Mean_aux=[];
std_aux=[];
Mean_result=[];
std_result=[];

for j=1:4
    Mean_aux=[];
    std_aux=[];
    for M=10:10:100
        B_test=[];
        for i=1:5
            t=tNtot(index(1:j*N));
            x=xNtot(index(1:j*N));
            ttest=tNtot(index(j*N+1:end));
            xtest=xNtot(index(j*N+1:end));
           
            [Wml,B]=RLMV(x,t,M,xtest,ttest,tipofb);
            B_test=[B_test B];
            tNtot=[tNtot(index(j*N+1:end)); tNtot(index(1:j*N))];
            xNtot=[xNtot(index(j*N+1:end)); xNtot(index(1:j*N))];            
        end
        Mean_aux=[Mean_aux mean(B_test)];
            std_aux=[std_aux std(B_test)];
    end
    Mean_result=[Mean_result;Mean_aux];
    std_result=[std_result;std_aux];
end
M=10;
Mean_result=Mean_result';
strdata=[]; 
disp('|M\N| 40        | 80           | 120  |160|')
disp('|:--:| :-------------: |:-------------:| :-----:| :-----:|')
for i=1:size(Mean_result,1)
    strdata=[strdata '|' num2str(M)];
    for j=1:size(Mean_result,2)
        strdata=[strdata '|' num2str(Mean_result(i,j))];
    end
    M=M+10;
    strdata=[strdata '|'];
    disp(strdata);
    strdata=[];
end
M=10
disp('|M\N| 40        | 80           | 120  |160|')
disp('|:--:| :-------------: |:-------------:| :-----:| :-----:|')
std_result=std_result';
strdata=[]; 
for i=1:size(std_result,1)
    strdata=[strdata '|' num2str(M)];
    for j=1:size(std_result,2)
        strdata=[strdata '|' num2str(std_result(i,j))];
    end
    M=M+10;
    strdata=[strdata '|'];
    disp(strdata);
    strdata=[];
end

%reset workspace
