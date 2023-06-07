function res = opred(x, N)
    global aa;
    global mm;
    
    X = zeros(N,1);
    for k=1:1:N
        X(k,1) = x(1)*exp(-i*2*pi*(k-1)*0/N);
        mm = mm + 1;
        for n=2:1:N
            X(k,1) = X(k,1) + x(n)*exp(-i*2*pi*(k-1)*(n-1)/N);
            mm = mm + 1;
            aa = aa + 1;
        end
    end
    res = X;
end