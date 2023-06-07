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
%disp('������� �������:');
%disp('������� �����');

% ��������� ������������ �������
[b,a]=cheby1(n,Rp,Wn,'high');
%disp('������������ b:');
%disp('������������ a:'); 

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
%figure(7)
%plot(nn,x1,nn,y1);
%title('The bandwidth of the sinusoid');
% �) � ������ �������������
f2 = 100;
x2 = sin(2*pi*f2*nn/Fd);
y2 = filter(b, a, x2);
%figure(8)
%plot(nn,x1,nn,y1);
%title('The band nontransmitting sinusoid');
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

global a;
global b;
global oldw;

% ������� ������� ������� �� ��������� �������,
% ��������� ����������� � �������������� �������
% ��������� �������
max = 100;
nn=0:max-1;
x = eye(1,100);
%���������� �����
[s t] = size(b);
oldw = zeros(1,t);
y = zeros(1,max);
for temp=1:max
y(temp) = myFilterCanon(x(temp));
end
figure(10);
plot(nn,h1,'r',nn,y,'g');
% �������������� ������
f = 300;
max = 100;
nn=0:max-1;
x=sin(2*pi*(f/Fd)*nn);
%���������� �����
[s t] = size(b);
oldw = zeros(1,t);
y = zeros(1,max);
for temp=1:max
y(temp) = myFilterCanon(x(temp));
end
figure(11);
plot(nn,x,'r',nn,y,'g',nn,y1,'b');
% ��������� ����������� ������
x = ones(1,100);
%������ �����
[s t] = size(b);
oldw = zeros(1,t);
y = zeros(1,max);
for temp=1:max
y(temp) = myFilterCanon(x(temp));
end
figure(12);
plot(nn,h2,'r',nn,y,'g');
% �������������� ������
f = 100;
max = 100;
nn=0:max-1;
x=sin(2*pi*(f/Fd)*nn);
%���������� �����
[s t] = size(b);
oldw = zeros(1,t);
y = zeros(1,max);
for temp=1:max
y(temp) = myFilterCanon(x(temp));
end
figure(13);
plot(nn,x,'r',nn,y,'g',nn,y2,'b');
