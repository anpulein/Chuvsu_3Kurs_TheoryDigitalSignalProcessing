% Задаём характеристики фильтра
% частота дискретизации
Fd = 1000;
% частоты среза полосы пропускания и
% полосы непропускания
fp = 220;
fs = 150;
% величины затуханий
Rp = 0.2;
Rs = 55;
% Нормализуем частоты
fd2 = Fd / 2;
Wp = fp / fd2;
Ws = fs / fd2;

% Расчёт фильтра
% Вычисляем порядок фильтра и частоту среза
[n, Wn] = cheb1ord(Wp,Ws,Rp,Rs);
%disp('Порядок фильтра:');
%disp('Частота среза');

% Вычисляем коэффициенты фильтра
[b,a]=cheby1(n,Rp,Wn,'high');
%disp('Коэффициенты b:');
%disp('Коэффициенты a:'); 

% Построение частотных характеристик
% Вычисляем частотную характеристику
[h,w]=freqz(b,a);
% Задаем сетку частот
ff = w/pi*fd2;

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
% на синусоидальный сигнал в полосе пропускания
% и непропускания
% а) в полосе пропускания
nn = (0:99);
f1 = 300;
x1 = sin(2*pi*f1*nn/Fd);
y1 = filter(b, a, x1);
figure(7)
plot(nn,x1,nn,y1);
title('The bandwidth of the sinusoid');

% б) в полосе непропускания
f2 = 100;
x1 = sin(2*pi*f2*nn/Fd);
y1 = filter(b, a, x1);
figure(8)
plot(nn,x1,nn,y1);
title('The band nontransmitting sinusoid');

% Получаем коэффициенты последовательной и параллельной % форм реализации фильтра
% Построение последовательной формы фильтра
disp('Коэффициенты последовательной формы:')
[sos, g] = tf2sos(b,a)
% Построение параллельной формы фильтра
disp('Коэффициенты последовательной формы:')
[r p k] = residuez(b, a);
Bi=[ ; ];
Ai =[ ; ];
for i = 1: 2: floor(n/2)*2
 [bi ai] = residuez(r(i : i+1), p(i : i+1), 0);
 Bi((i+1)/2, :) = bi;
 Ai((i+1)/2, :) = ai;
end
Bi(5,:)=[r(9) 0 0];
Ai(5,:)=[1 -p(9) 0];
