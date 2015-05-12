clear all
close all
plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],'b'),'EdgeColor',color,'FaceAlpha',0.3,'EdgeAlpha',0.3);
data=load('ejemplo_regresion.mat');
xNtot=data.x;
yNtot=data.y;
tNtot=data.t;

Ntot=size(xNtot,1);
N=40;
index=randperm(Ntot);
t=tNtot(index(1:N));
x=xNtot(index(1:N));
tipofb='poly';
M=30;
ttest = tNtot(index(N+1:end));
xtest = xNtot(index(N+1:end));

B_test=[];
Mean_aux=[];
std_aux=[];
Mean_result=[];
std_result=[];
min_error=inf;
max_error=0;
W_min=[];


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
            [Sn,mn,E,alpha,betae]=RLB(x,t,M,xtest,ttest,tipofb);
            PHIt    = genBasisFunction(tipofb,xNtot,Ntot,M);
            B_test=[B_test E];
            tNtot=[tNtot(index(j*N+1:end)); tNtot(index(1:j*N))];
            xNtot=[xNtot(index(j*N+1:end)); xNtot(index(1:j*N))];
        end
        Mean_aux=[Mean_aux mean(B_test)];
        std_aux=[std_aux std(B_test)];
        
        
        if mean(B_test)>max_error
            max_error=mean(B_test);
            Sn_max= Sn;
            mn_max=mn;
            alpha_max= alpha;
            beta_max=betae;
            M_max=M;
            N_max=N*j;
        end
        
        if mean(B_test)<min_error
            min_error=mean(B_test);
            Sn_min= Sn;
            mn_min=mn;
            alpha_min= alpha;
            beta_min=betae;
            M_min=M;
            N_min=N*j;
        end
    end
    Mean_result=[Mean_result;Mean_aux];
    std_result=[std_result;std_aux];       
end
PHIt    = genBasisFunction(tipofb,data.x,length(data.x),M_min);
[mean_pre,varianza]=model(PHIt,Ntot,Sn_min,mn_min,beta_min);


figure
hold on
plot_variance(data.x',(mean_pre-2*varianza)',(mean_pre+2*varianza)',[1 1 1])
plot(data.x,mean_pre,'r')
plot(data.x, data.y, 'b', 'linewidth', 1.5)
plot(x, t, '.k')
set(gca, 'ylim', [-2 3])
h_legend=legend('varianza','Funcion original','Modelo','Muestras');
set(h_legend,'FontSize',7);


PHIt    = genBasisFunction(tipofb,data.x,length(data.x),M_max);
[mean_pre,varianza]=model(PHIt,Ntot,Sn_max,mn_max,beta_max);


figure
hold on
plot_variance(data.x',(mean_pre-2*varianza)',(mean_pre+2*varianza)',[1 1 1])
plot(data.x,mean_pre,'r')
plot(data.x, data.y, 'b', 'linewidth', 1.5)
plot(x, t, '.k')
set(gca, 'ylim', [-2 3])
h_legend=legend('varianza','Funcion original','Modelo','Muestras');
set(h_legend,'FontSize',7);

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
filename=[tipofb '_WB.mat'];
save(filename,'Sn_max','mn_max','alpha_max','beta_max','Sn_min','mn_min','alpha_min','beta_min','M_max','M_min','N_max','N_min');