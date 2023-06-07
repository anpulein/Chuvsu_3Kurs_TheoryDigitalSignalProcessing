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

%figure(5)
h1=impz(b,a,100);
% Временная характеристика
%figure(6)
h2=stepz(b,a,100);
% Вычисление и построение реакции фильтра
% на синусоидальный сигнал в полосе пропускания
% и непропускания
% а) в полосе пропускания
nn = (0:99);
f1 = 300;
x1 = sin(2*pi*f1*nn/Fd);
y1 = filter(b, a, x1);
%figure(7)
%plot(nn,x1,nn,y1);
%title('The bandwidth of the sinusoid');
% б) в полосе непропускания
f2 = 100;
x2 = sin(2*pi*f2*nn/Fd);
y2 = filter(b, a, x2);
%figure(8)
%plot(nn,x1,nn,y1);
%title('The band nontransmitting sinusoid');
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
Bi(5, :) = [r(9) 0 0]
Ai(5, :) = [1 -p(9) 0]

global a;
global b;
global oldw;
global m;
m= 4096;
a= round(a*m);
b= round(b*m);
% Получим реакцию фильтра на единичный импульс,
% единичный ступенчатый и синусоидальный сигналы
% Единичный импульс
max = 100;
nn=0:max-1;
x = eye(1,100);
x=round(x*m);
%Прямая форма
[s t] = size(b);
oldw = zeros(1,t);
y = zeros(1,max);
for temp=1:max
y(temp) = myFilterCanonInt(x(temp));
end
figure(10);
%plot(nn,y);
plot(nn,h1*m,'r',nn,y,'g');
% Синусоидальный сигнал
f = 300;
max = 100;
nn=0:max-1;
x=sin(2*pi*(f/Fd)*nn);
x=round(x*m);
%Прямая форма
[s t] = size(b);
oldw = zeros(1,t);
y = zeros(1,max);
for temp=1:max
y(temp) = myFilterCanonInt(x(temp));
end
figure(11);
%plot(nn,y);
plot(nn,x,'r',nn,y,'g',nn,y1*m,'b');
% Единичный ступенчатый сигнал
x = ones(1,100);
x=round(x*m);
%Прямая форма
[s t] = size(b);
oldw = zeros(1,t);
y = zeros(1,max);
for temp=1:max
y(temp) = myFilterCanonInt(x(temp));
end
figure(12);
%plot(nn,y);
plot(nn,h2*m,'r',nn,y,'g');
% Синусоидальный сигнал
f = 100;
max = 100;
nn=0:max-1;
x=sin(2*pi*(f/Fd)*nn);
x=round(x*m);
%Прямая форма
[s t] = size(b);
oldw = zeros(1,t);
y = zeros(1,max);
for temp=1:max
y(temp) = myFilterCanonInt(x(temp));
end
figure(13);
%plot(nn,y);
plot(nn,x,'r',nn,y,'g',nn,y2*m,'b');
