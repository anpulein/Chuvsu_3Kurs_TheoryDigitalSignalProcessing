function r = fft64(x)
global aa;
global mm;

N = length(x);

if N == 1
    r = x;
else
    X_even = fft64(x(1:2:N));
    X_odd = fft64(x(2:2:N));
    factor = exp(-2i * pi * (0:N/2-1)/N);
    r = [X_even + factor .* X_odd, X_even - factor .* X_odd];
    aa = 64 * log2(64) + aa;
    mm = 32 * log2(64) + mm;
end















