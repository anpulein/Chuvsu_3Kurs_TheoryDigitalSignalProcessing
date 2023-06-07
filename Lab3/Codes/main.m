clear;

global kl_tk_a;
global kl_tk_m;
global opred_3_a;
global opred_3_m;
global opred_15_a; 
global opred_15_m;
global opred_5_a;
global opred_5_m;
kl_tk_a = 0;
kl_tk_m = 0;
opred_3_a = 0;
opred_3_m = 0;
opred_15_m = 0;
opred_15_a = 0;
opred_5_a = 0;
opred_5_m = 0;


fd = 48;
f1 = 3;
N = 15;
t = 0 : N - 1;
%X = sin(t * 2 * pi * f1 / fd);
%X=eye(1,15);
%X=ones(1,15);
n = 0 : N - 1;
X = sin(pi*5/43*n);
Y1 = kl_tk15(X);

Y1

figure(1);
plot(n,X); grid on;  title('Исходный сигнал')

figure(2);
subplot(1, 2, 1);
stem(n, abs(Y1), 'g'); grid on; title('ДПФ по Кули-Тьюки');

Y2 = opred_3(X,15);

subplot(1, 2, 2);
plot(n, abs(Y2), 'r'); grid on; title('ДПФ по определению');

figure(3);
subplot(2, 1, 1);
stem(n, X, 'g'); grid;

X1=kl_tk15(Y1') / N;
subplot(2, 1, 2);
stem(n, X1, 'r'); grid;