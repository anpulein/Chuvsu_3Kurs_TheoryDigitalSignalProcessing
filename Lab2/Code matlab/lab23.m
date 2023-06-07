% Основная программа
% представим коэффициенты в целом виде, умножив их 
% на значение m
global Ai;
global Bi;
global oldx;
global oldy;
global k;
global m;
global sos;
global g;
Fd = 1000;
b = [0.0702   -0.2920    0.6013   -0.7527    0.6013   -0.2920    0.0702];
a = [1.0000   -0.0408    1.4466    0.2778    0.6242    0.1762    0.0846];
Ai = [ 1.0000   -0.4031    0.8844; 1.0000   -0.0806    0.5785; 1.0000    0.4429    0.1654];
Bi = [ 0.1301  -0.0598   0.0000; -0.2781   0.4414   0.0000; -0.6108  -0.9713   0.0000];
sos = [ 1.0000   -1.8720    1.0000    1.0000    0.4429    0.1654 1.0000   -1.3039    1.0000    1.0000   -0.0806    0.5785 1.0000   -0.9853    1.0000    1.0000   -0.4031    0.8844 ];
k = 0.8289;
m = 4096;
g = 0.0702;
sos = round(m*sos);
g = round(m*g);
Ai = round(m*Ai);
Bi = round(m*Bi);
k = round(k*m);
% Единичный импульс
max = 100;
nn=0:max-1;
x = eye(1,100);
x_int=m*x;
y1 = filter(b, a, x);
% параллельная форма
oldx = 0;
[s t] = size(Ai);
oldy = zeros(1,2*s);
y = zeros(1,max);
for temp=1:max
 y(temp) = myFilterParallelInt(x_int(temp));
end
figure(13);
plot(nn,y1 * m,'r',nn,y,'g');
% Синусоидальный сигнал
f = 300;
max = 100;
nn=0:max-1;
x=sin(2*pi*(f/Fd)*nn);
y1 = filter(b, a, x);
x_int=round(m*x);
% параллельная форма
oldx = 0;
[s t] = size(Ai);
oldy = zeros(1,2*s);
y = zeros(1,max);
for temp=1:max
 y(temp) = myFilterParallelInt(x_int(temp));
end
figure(14);
plot(nn,y1 * m,'r',nn,y,'g');
% Единичный ступенчатый сигнал
x = ones(1,100);
x_int = m*x; 
y1 = filter(b, a, x);
% параллельная форма
oldx = 0;
[s t] = size(Ai);
oldy = zeros(1,2*s);
y = zeros(1,max);
for temp=1:max
 y(temp) = myFilterParallelInt(x_int(temp));
end
figure(15);
plot(nn,y1 * m,'r',nn,y,'g');
