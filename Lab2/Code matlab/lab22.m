global a;
global b;
global Ai;
global Bi;
global oldx; 
global oldy; 
global oldw;
Fd = 1000;
b = [0.0702   -0.2920    0.6013   -0.7527    0.6013   -0.2920    0.0702];
a = [1.0000   -0.0408    1.4466    0.2778    0.6242    0.1762    0.0846];
Ai = [ 1.0000   -0.4031    0.8844 1.0000   -0.0806    0.5785 1.0000    0.4429    0.1654 ];
Bi = [ 0.1301 - 0.0000i  -0.0598 + 0.0000i   0.0000 + 0.0000i -0.2781 + 0.0000i   0.4414 + 0.0000i   0.0000 + 0.0000i -0.6108 + 0.0000i  -0.9713 - 0.0000i   0.0000 + 0.0000i];
% Получим реакцию фильтра на единичный импульс,
% единичный ступенчатый и синусоидальный сигналы
% Единичный импульс
max = 100;
nn=0:max-1;
x = eye(1,100);
y1 = filter(b, a, x);
%Прямая форма
[s, t] = size(b);
oldx = zeros(1,t);
oldy = zeros(1,t);
y = zeros(1,max);
for temp=1:max
 y(temp) = myFilterDirect(x(temp));
end
figure(10);
plot(nn,y1,'r',nn,y,'g');
% Синусоидальный сигнал
f = 300;
max = 100;
nn=0:max-1;
x=sin(2*pi*(f/Fd)*nn);
y1 = filter(b, a, x);
%Прямая форма
[s, t] = size(b);
oldx = zeros(1,t);

oldy = zeros(1,t);
y = zeros(1,max);
for temp=1:max
 y(temp) = myFilterDirect(x(temp));
end
figure(11);
plot(nn,y1,'r',nn,y,'g');
% Единичный ступенчатый сигнал
x = ones(1,100);
y1 = filter(b, a, x);
%Прямая форма

[s, t] = size(b);
oldx = zeros(1,t);
oldy = zeros(1,t);
y = zeros(1,max);
for temp=1:max
 y(temp) = myFilterDirect(x(temp));
end
figure(12);
plot(nn,y1,'r',nn,y,'g');