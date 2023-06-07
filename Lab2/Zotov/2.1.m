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

% ���������� ���
figure(1)
plot(ff, abs(h));
title('Amplitude frequency characteristic');
xlabel('Frequency');
ylabel('Amplitude');

% ���������� ���
figure(2)
plot(ff, unwrap(angle(h)));
title('Phase frequency characteristic');
xlabel('Frequency');
ylabel('Phase');

% ���������� ����
figure(3)
plot(ff, 20 * log10(abs(h)));
title('Logarithmic amplitude frequency characteristic');
xlabel('Frequency');
ylabel('Amplitude');

% ���������� ��������� ��������
figure(4)
gd = grpdelay(b, a);
plot(ff, gd);
xlabel('Frequency');
ylabel('delay');
title('Group delay');

% ���������� ���������� � ��������� �������������
% ���������� ��������������
figure(5)
impz(b,a);

% ��������� ��������������
figure(6)
stepz(b,a);

% ���������� � ���������� ������� �������
% �� �������������� ������ � ������ �����������
% � �������������
% �) � ������ �����������
nn = (0:99);
f1 = 300;
x1 = sin(2*pi*f1*nn/Fd);
y1 = filter(b, a, x1);
figure(7)
plot(nn,x1,nn,y1);
title('The bandwidth of the sinusoid');

% �) � ������ �������������
f2 = 100;
x1 = sin(2*pi*f2*nn/Fd);
y1 = filter(b, a, x1);
figure(8)
plot(nn,x1,nn,y1);
title('The band nontransmitting sinusoid');

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
Bi(5,:)=[r(9) 0 0];
Ai(5,:)=[1 -p(9) 0];
