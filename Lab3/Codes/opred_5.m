function Y = opred_5(X, N)
global opred_5_a;
global opred_5_m;
global opred_15_a;
global opred_15_m;
Y = zeros(1, N);
first5 = 0;
if opred_5_m == 0 
    first5 = 1;
end

for k = 1 : N
    for n = 1 : N
        Y(k) = Y(k) +  X(n) * exp(-1i * 2 * pi * (n - 1) * (k - 1) / N);
        if N == 5
            if first5 == 1
                opred_5_a = opred_5_a + 1;
                opred_5_m = opred_5_m + 1;
            end
        end
        if N == 15
            opred_15_m = opred_15_a + 1;
            opred_15_a = opred_15_a + 1;
        end
    end
end

if N == 5
    if first5 == 1
        opred_5_a = opred_5_a - 3;
    end
end
if N == 15
    opred_15_a = opred_15_a - 15;
end