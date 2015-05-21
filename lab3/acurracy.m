function accurr=acurracy(Y,t)
    Y_b=zeros(size(Y));
    N=length(t);
    true_positive=0;
    for i=1:N
        [max_y,id]=max(Y(i,:));
        if t(i,id)==1
            Y_b(i,id)=1;
            true_positive=true_positive+1;
        end
    end
    accurr=true_positive/N;
end