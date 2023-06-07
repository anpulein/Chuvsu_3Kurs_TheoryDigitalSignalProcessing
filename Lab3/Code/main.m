clear;

global aa;
global mm;


aa = 0;
mm = 0;
N1 = 64;
N2 = 5;
N  = N1 * N2;
Y  = zeros(N1, N2);


n = 0:N - 1;
X = sin(2 * pi * 2 / 56 * n);


% Исходный сигнал
figure(1);
plot(n,X);
title('Исходный сигнал');

% 1) Отображение входной последовательности в 2-мерную таблицу;
for i = 1 : N1
    for j = 1 : N2
        Y(i, j) = X((i - 1) * N2 + j);
    end
end

% Для каждого столбца

for j = 1 : N2
     x = Y(: , j);
     disp(x);
     xx = fft64(x);
     Y(: , j) = xx;
end



% 3) Поэлементное умножение всех элементов таблицы
for i = 1 : N1
     for j = 1 : N2
        Y(i, j) = Y(i, j) * exp(-1i * 2 * pi * (i - 1) * (j - 1) / N);
        mm = mm + 1;
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


figure(2);
plot(0:N-1,abs(Z));
title('собственная реализация БПФ');
figure(3);
plot(0:N-1, abs(fft(X)));
title('готовая БПФ');

disp('M =');
disp(mm);
disp('A =');
disp(aa);

figure(4);
Y1 = idt(Z);
Y = real(Y1);
plot(n, X, n,Y);
title('Обратное преобразование');


