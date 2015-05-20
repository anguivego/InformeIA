function [W,squareError]=minSqrt(X,T)
    W=(X'*X)\(X'*T);
    squareError=0.5*trace((X*W-T)'*(X*W-T));
end