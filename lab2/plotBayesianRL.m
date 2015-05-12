function plotBayesianRL(tipofb,dataFile,parametersFile)
    data=load(dataFile);
    plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],'b'),'EdgeColor',color,'FaceAlpha',0.3,'EdgeAlpha',0.3);

    xNtot=data.x;
    yNtot=data.y;
    tNtot=data.t;
    Ntot=size(xNtot,1);

    load(parametersFile);


    PHIt    = genBasisFunction(tipofb,data.x,length(data.x),M_min);
    [mean_pre,varianza]=model(PHIt,Ntot,Sn_min,mn_min,beta_min);

    subplot(2,1,1)
    hold on
    plot_variance(data.x',(mean_pre-2*varianza)',(mean_pre+2*varianza)',[1 1 1])
    plot(data.x,mean_pre,'r')
    plot(data.x, data.y, 'b', 'linewidth', 1.5)
    set(gca, 'ylim', [-2 6])
    str1 = ['\leftarrow M=' num2str(M_min) ' N=' num2str(N_min)];
    text(data.x(20),data.y(20),str1)
    h_legend=legend('varianza','Funcion original','Modelo');
    set(h_legend,'FontSize',7);




    PHIt    = genBasisFunction(tipofb,data.x,length(data.x),M_max);
    [mean_pre,varianza]=model(PHIt,Ntot,Sn_max,mn_max,beta_max);


    subplot(2,1,2)
    plot_variance(data.x',(mean_pre-2*varianza)',(mean_pre+2*varianza)',[1 1 1])
    hold on
    plot(data.x,mean_pre,'r')
    plot(data.x, data.y, 'b', 'linewidth', 1.5)
    set(gca, 'ylim', [-2 6])
    str1 = ['\leftarrow M=' num2str(M_max) ' N=' num2str(N_max)];
    text(data.x(20),data.y(20),str1)
    h_legend=legend('varianza','Funcion original','Modelo');
    set(h_legend,'FontSize',7);
end