%pkg load signal

% Задаем характиристики фильтра
% Частота дискретизации
Fd = 1000
% Частота среза полосы пропускания и непропускания
fp = 220
fs = 150
% Величины затухания
Rp = 0.2
Rs = 55


% Нормализуем частоты
FdN = Fd / 2
Wp = fp / FdN
Ws = fs / FdN


% Расчет фильра
% Вычисляем порядок фильтра и частоту среза
[n, Wn] = buttord(Wp, Ws, Rp, Rs)


% Вычисляем коэффициенты фильтра
[b, a] = butter(n, Wn, 'high')

%-------------------------------------------------------------

% Построение частотных характеристик
% Вычисляем частотную характеристику
[h,w]=freqz(b,a);
% Задаем сетку частот
ff = w/pi*FdN;

% Построение АЧХ
figure(1)
plot(ff, abs(h));
title('Amplitude frequency characteristic');
xlabel('Frequency');
ylabel('Amplitude');


% Построение ФЧХ
figure(2)
plot(ff, unwrap(angle(h)));
title('Phase frequency characteristic');
xlabel('Frequency');
ylabel('Phase');


% Построение ЛАЧХ
figure(3)
plot(ff, 20 * log10(abs(h)));
title('Logarithmic amplitude frequency characteristic');
xlabel('Frequency');
ylabel('Amplitude');


% Построение групповой задержки
figure(4)
gd = grpdelay(b, a);
plot(ff, gd);
xlabel('Frequency');
ylabel('delay');
title('Group delay');

% Построение импульсной и временной характеристик
% Импульсная характеристика
figure(5)
impz(b,a);


% Временная характеристика
figure(6)
stepz(b,a);


% Вычисление и построение реакции фильтра
% на синусоидальный сигнал в полосе пропускания и непропускания
% a) в полосе пропускания
nn = (0:99)
f1 = 300
x1 = sin(2*pi*f1*nn/Fd)
y1 = filter(b, a, x1)
figure(7)
plot(nn, x1, nn, y1)
title('The bandwidth of the sinusiod')


% б) в полосе непропускания
f2 = 800
x1 = sin(2*pi*f2*nn/Fd)
y1 = filter(b, a, x1)
figure(8)
plot(nn, x1, nn, y1)
title('The band notransmitting sinusiod')


i=eye(1,100); %Формируем вектор, у которого
%первый отсчет - единица,
%а остальные 99 отсчетов - нули.
h=filter(b,a,i); %Вычисляем импульсную
 %характеристику.

% Получаем коэффициенты последовательной и
% параллельной форм реалезации фильтра
% Построение последовательной формы фильтра
[sos, g] = tf2sos(b, a)


% Построение параллельной формы фильтра
[r p k] = residuez(b, a)
Bi=[ ; ]
Ai = [ ; ]

for i = 1: 2: floor(n/2)*2
    [bi ai] = residuez(r(i : i+1), p(i : i+1), 0)
    Bi((i + 1)/2, : ) = bi
    Ai((i + 1)/2, : ) = ai
end

Bi(9, :) = [r(17) 0 0]
Ai(9, :) = [1 -p(17) 0]