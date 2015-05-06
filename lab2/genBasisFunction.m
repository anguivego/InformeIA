function PHI=genBasisFunction(tipofb,x,N,M)
    % Se calcula la matrix de diseno para los datos de entrenamiento
    mu = linspace(0, 1, M-1)';
    aux = diff(mu);
    s2 = 0.5*aux(1);
    PHI = zeros(N, M);
    PHI(:, 1) = ones(N, 1);
    for i=2:M
        switch tipofb
            case 'exp'
                PHI(:, i) = exp(-((x - mu(i-1)).^2)/(2*s2)); % Exponencial
            case 'poly'
                PHI(:, i) = x.^(i-1); % Polinomial
            case 'tan'
                PHI(:, i) = 1./(1 + exp(-(x - mu(i-1))/(sqrt(s2)))); % Sigmoidal
            otherwise
                error('fb:unknown', 'La funcion base es desconocida');
        end
    end
end