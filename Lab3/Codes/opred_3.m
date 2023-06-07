function Y = opred_3(X, N)
global opred_3_a;
global opred_3_m;
global opred_15_a;
global opred_15_m;
Y = zeros(1, N);
first3 = 0;
if opred_3_m == 0 
    first3 = 1;
end

for k = 1 : N
    for n = 1 : N
        Y(k) = Y(k) +  X(n) * exp(-1i * 2 * pi * (n - 1) * (k - 1) / N);
        if N == 3
            if first3 == 1
                opred_3_a = opred_3_a + 1;
                opred_3_m = opred_3_m + 1;
            end
        end
        if N == 15
            opred_15_m = opred_15_a + 1;
            opred_15_a = opred_15_a + 1;
        end
    end
end

if N == 3
    if first3 == 1
        opred_3_a = opred_3_a - 3;
    end
end
if N == 15
    opred_15_a = opred_15_a - 15;
end