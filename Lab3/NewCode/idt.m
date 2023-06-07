function res = idt(X)

X = conj(X);
N1 = 8;
N2 = 7;
N  = N1 * N2;

% 1) Отображение входной последовательности в 2-мерную таблицу;
for i = 1 : N1
    for j = 1 : N2
        Y(i, j) = X((i - 1) * N2 + j);
    end
end

% Для каждого столбца

for j = 1 : N2
    %x = Y(: , j);
    %xx = fft(x);
    Y(: , j) = fft8(Y(: , j));
    %Y(: , j) = xx;
end



% 3) Поэлементное умножение всех элементов таблицы
for i = 1 : N1
     for j = 1 : N2
        Y(i, j) = Y(i, j) * exp(-1i * 2 * pi * (i - 1) * (j - 1) / N);
     end
end

% Для каждой строки

for i= 1 : N1
    Y(i, :) = opred(Y(i, :), N2);
end

% 
% 5) Отображение 2-мерной таблицы в выходную последовательность
Z = zeros(1, N);
for i = 1 : N2
     for j = 1 : N1
        Z((i - 1) * N1 + j) = Y(j, i);
     end
end

Z = conj(Z);
Z= Z / N;
res = Z;