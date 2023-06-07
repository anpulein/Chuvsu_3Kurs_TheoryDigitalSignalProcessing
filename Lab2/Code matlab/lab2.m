Fd = 1000;
Fp = 220;
Fs = 150;
Rp = 0.2;
Rs = 55;
%Нормализуем частоты
Fd2 = Fd / 2;
Wp = Fp / Fd2;
Ws = Fs / Fd2;

%1.1 Составить программу расчета БИХ-фильтра
[n, Wn] = ellipord(Wp, Ws, Rp, Rs);
[b, a] = ellip(n, Rp, Rs, Wn, 'high');

%1.2 Построить частотные характеристики
[h, w] = freqz(b, a); %частотная характеристика
ff = w / pi * Fd2;
figure(1);
plot(ff, abs(h));
title('АЧХ');
figure(2);
plot(ff, unwrap(angle(h)));
title('ФЧХ');
figure(3)
plot(ff, 20 * log10(abs(h)));
grid;
title('ЛАЧХ');
gd = grpdelay(b, a);
figure(4)
plot(ff, gd);
title('Групповая задержка');

%1.3 Построение импульсной и временной хрт
figure(5);
impz(b, a);
title('Импульсная характеристика');
figure(6);
stepz(b, a);
title('Временная характеристика');

%Реакция фильтра на синусоидальный сигнал
%Из полосы пропускания
nn = (0:99);
f1 = 300;
x1 = sin(2*pi*f1*nn/Fd);
y1 = filter(b, a, x1);
figure(7)
plot(nn,x1,nn,y1);
title('Из полосы пропускания');

f2 = 100;
x1 = sin(2*pi*f2*nn/Fd);
y1 = filter(b, a, x1);
figure(8)
plot(nn,x1,nn,y1);
title('Из полосы непропускания');

[sos, g] = tf2sos(b,a)
[r p k] = residuez(b, a);
Bi=[ ; ];
Ai =[ ; ];

for i = 1: 2 : floor(n/2)*2;
 [bi ai] = residuez(r(i : i+1), p(i : i+1), 0);
 Bi((i+1)/2, :) = bi;
 Ai((i+1)/2, :) = ai;
end
Bi
Ai
b
a
k