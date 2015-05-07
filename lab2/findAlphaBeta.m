function [alpha,beta]=findAlphaBeta(PHI,M,N,t)
    alpha = 1e-3;
    betae = 1;
    [V, D] = eig(PHI'*PHI);
    rho = diag(D);
    lambda = betae*rho;

    niters = 20;
    betav = zeros(niters+1, 1);
    alphav = zeros(niters+1, 1);
    betav(1) = betae;
    alphav(1) = alpha;

    for n = 1:niters
        A = alpha*eye(M) +  betae*(PHI'*PHI);
        Ainv = A\eye(M);
        mN = betae*Ainv*PHI'*t;
        gamma = sum((lambda)./(lambda + alpha));
        alpha = gamma/(mN'*mN);
        aux = (t - PHI*mN);
        betaeInv = (aux'*aux)/(N - gamma);
        betae = 1/betaeInv;
        lambda = betae*rho;
        betav(n+1) = betae;
        alphav(n+1) = alpha;
    end
    beta=betae;
end
