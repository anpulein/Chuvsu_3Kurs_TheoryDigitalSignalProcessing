function [ Y ] = kl_tk15( X )
global kl_tk_a
global kl_tk_m
global opred_3_a;
global opred_3_m;
global opred_5_a;
global opred_5_m;
first = 0;
if kl_tk_m == 0 
    first = 1;
end
N  = 15;
N1 = 5;
N2 = 3;
Y  = zeros(N1, N2);

% 1) Отображение входной последовательности в 2-мерную таблицу
for n = 1 : N2
    for j = 1 : N1
        Y(n, j) = X((n - 1) * N1 + j);
    end
end

% 2) Вычисление ДПФ каждого столбца (N1 ДПФ длиной N2)
for n = 1 : N1
     temp = opred_3(Y( : , n), N2);
     for j = 1 : N2
         Y(j, n) = temp(j);
     end
end

if first == 1
    kl_tk_a = kl_tk_a + opred_3_a * N1;
    kl_tk_m = kl_tk_m + opred_3_m * N1;
end

%3) N умножений на поворачивающий множитель Wn^(nk)
for n = 1 : N2
     for k = 1 : N1
        Y(n, k) = Y(n, k) * exp(-1i * 2 * pi * (k - 1) * (n - 1) / N);
     end
end
if first == 1
    kl_tk_m = kl_tk_m + N;
end

%4) Вычисление ДПФ каждой строки (N2 ДПФ длиной N1)
for n = 1 : N2
    Y(n, :) = opred_5(Y(n, :),N1);
end
if first == 1
    kl_tk_a = kl_tk_a + opred_5_a * N2;
    kl_tk_m = kl_tk_m + opred_5_m * N2;
end

%5) Отображение 2-мерной таблицы в выходную последовательность
for i = 1 : N2
     for j = 1 : N1
        X((i - 1) * N2 + j) = Y(j, i);
     end
end
Y = X;