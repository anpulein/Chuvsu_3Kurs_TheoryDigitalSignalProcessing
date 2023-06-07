% ����� �������������� �������
% ������� �������������
Fd = 1000;
% ������� ����� ������ ����������� �
% ������ �������������
fp = 220;
fs = 150;
% �������� ���������
Rp = 0.2;
Rs = 55;
% ����������� �������
fd2 = Fd / 2;
Wp = fp / fd2;
Ws = fs / fd2;

% ������ �������
% ��������� ������� ������� � ������� �����
[n, Wn] = cheb1ord(Wp,Ws,Rp,Rs);

% ��������� ������������ �������
[b,a]=cheby1(n,Rp,Wn,'high');

% ���������� ��������� �������������
% ��������� ��������� ��������������
[h,w]=freqz(b,a);
% ������ ����� ������
ff = w/pi*fd2;

%figure(5)
h1=impz(b,a,100);
% ��������� ��������������
%figure(6)
h2=stepz(b,a,100);
% ���������� � ���������� ������� �������
% �� �������������� ������ � ������ �����������
% � �������������
% �) � ������ �����������
nn = (0:99);
f1 = 300;
x1 = sin(2*pi*f1*nn/Fd);
y1 = filter(b, a, x1);

% �) � ������ �������������
f2 = 100;
x2 = sin(2*pi*f2*nn/Fd);
y2 = filter(b, a, x2);

% �������� ������������ ���������������� � ������������ % ���� ���������� �������
% ���������� ���������������� ����� �������
disp('������������ ���������������� �����:')
[sos, g] = tf2sos(b,a)
% ���������� ������������ ����� �������
disp('������������ ���������������� �����:')
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
global Ai;
global Bi;
global oldx;
global oldy;
global k;
% ������� ������� ������� �� ��������� �������,
% ��������� ����������� � �������������� �������
% ��������� �������
max = 100;
nn=0:max-1;
x = eye(1,100);
%����������� �����
[s t] = size(b);
oldx = 0;
oldy = zeros(1,t);
y = zeros(1,max);
for temp=1:max
    y(temp) = myFilterParallel(x(temp));
end
figure(10);
plot(nn,h1,'r',nn,y,'g');
% �������������� ������
f = 300;
max = 100;
nn=0:max-1;
x=sin(2*pi*(f/Fd)*nn);
%����������� �����
[s t] = size(b);
oldx = 0;
oldy = zeros(1,t);
%Ai = zeros(1,t);
%Bi = zeros(1,t);
%k = zeros(1,t);
y = zeros(1,max);
for temp=1:max
y(temp) = myFilterParallel(x(temp));
end
figure(11);
plot(nn,x,'r',nn,y,'g',nn,y1,'b');
% ��������� ����������� ������
x = ones(1,100);
%����������� �����
[s t] = size(b);
oldx = 0;
oldy = zeros(1,t);
%Ai = zeros(1,t);
%Bi = zeros(1,t);
%k = zeros(1,t);
y = zeros(1,max);
for temp=1:max
y(temp) = myFilterParallel(x(temp));
end
figure(12);
plot(nn,h2,'r',nn,y,'g');
% �������������� ������
f = 100;
max = 100;
nn=0:max-1;
x=sin(2*pi*(f/Fd)*nn);
%����������� �����
[s t] = size(b);
oldx = 0;
oldy = zeros(1,t);
y = zeros(1,max);
for temp=1:max
y(temp) = myFilterParallel(x(temp));
end
figure(13);
plot(nn,x,'r',nn,y,'g',nn,y2,'b');
