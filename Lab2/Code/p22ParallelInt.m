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

% Построение импульсной и временной характеристик
% Импульсная характеристика
% figure(5)
h1 = impz(b,a, 100);

% Временная характеристика
% figure(6)
h2 = stepz(b,a, 100);


% Вычисление и построение реакции фильтра
% на синусоидальный сигнал в полосе пропускания и непропускания
% a) в полосе пропускания
nn = (0:99)
f1 = 300
x1 = sin(2*pi*f1*nn/Fd)
y1 = filter(b, a, x1)


% б) в полосе непропускания
f2 = 100
x2 = sin(2*pi*f2*nn/Fd)
y2 = filter(b, a, x2)

% Получаем коэффициенты последовательной и
% параллельной форм реалезации фильтра
% Построение последовательной формы фильтра
[sos, g] = tf2sos(b, a)


% Построение параллельной формы фильтра
[r p k] = residuez(b, a)
Bi=[ ; ]
Ai = [ ; ]

%r = real(r);
%p = real(p);

for i = 1: 2: floor(n/2)*2
    [bi ai] = residuez(r(i : i+1), p(i : i+1), 0)
    Bi((i + 1)/2, : ) = bi
    Ai((i + 1)/2, : ) = ai
end

Bi(9, :) = [r(17) 0 0]
Ai(9, :) = [1 -p(17) 0]

% Программка 

global Ai;
global Bi;
global oldx;
global oldy;
global k;
global m1;
m1 = 128;
m = 1024;
a = round(a*m);
b = round(b*m);
Ai = round(Ai);
Bi = round(Bi * m1);
k = round(k);

% Получим реакцию фильтра на единичный импульс,
% единичный ступенчатый и синусоидальный сигналы
% Единичный импульс
% Синусоидальный сигнал
max = 100;
nn=0:max-1;
x = eye(1,100);
x = round(x * m);
% Прямая форма
[s t] = size(b);
oldx=0;
oldy = zeros(1,t);
y = zeros(1,max);
for temp=1:max
    y(temp) = filterParallelInt(x(temp));
end
figure(10);
plot(nn,h1 * m,'r',nn,y,'g');

% Синусоидальный сигнал
f = 300;
max = 100;
nn=0:max-1;
x=sin(2*pi*(f/Fd)*nn);
x = round(x * m);
% Прямая форма
[s t] = size(b);
oldx = 0;
oldy = zeros(1,t);
y = zeros(1,max);
for temp=1:max
    y(temp) = filterParallelInt(x(temp));
end
figure(11);
plot(nn,x,'r',nn,y,'g',nn,y1 * m,'b');

% Единичный ступенчатый сигнал
x = ones(1, 100);
x = round(x * m);
% Прямая форма
[s t] = size(b);
oldx = 0;
oldy = zeros(1,t);
y = zeros(1,max);
for temp=1:max
    y(temp) = filterParallelInt(x(temp));
end
figure(12);
plot(nn,h2 * m,'r',nn,y,'g');

% Синусоидальный сигнал
f = 100;
max = 100;
nn=0:max-1;
x=sin(2*pi*(f/Fd)*nn);
x = round(x * m);
% Прямая форма
[s t] = size(b);
oldx = 0;
oldy = zeros(1,t);
y = zeros(1,max);
for temp=1:max
    y(temp) = filterParallelInt(x(temp));
end
figure(13);
plot(nn,x,'r',nn,y,'g',nn,y2 * m,'b');


