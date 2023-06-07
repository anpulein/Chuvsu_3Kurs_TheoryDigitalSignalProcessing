 % Частоты синусоид
 f1 = 320; 
 f2 = 336; 
 k0=2.39;   %коэффициент, зависящий от вида окна 
 df=16;     % Разрешающая способность
 fd=4096;   % частота дискритизации
 T=8;       % Время наблюдения
 E=0.08;    % Нормированная случайная ошибка
 
 
 mur = 0;
 adr = 0;
 muc = 0;
 adc = 0;
 
 
 N=fd*T     %количество отсчётов
 M=2^ceil(log2(fd/df*k0))  %число обрабатываемых на интервале отсчётов
 V=ceil(1/(E^2)) % Кол-во отрезков
 Sdvig=floor((N-M)/V) % Сдвиг
 Wch=1-(Sdvig/M); % Перекрытие

 disp(E)
 
 Td=1/fd;
 t=(0:N-1)*Td;
 x=sin(2*pi*f1*t)+sin(2*pi*f2*t)+randn(1,N);
 n =0:N-1;
 figure(1)
 plot(n,x)
 subtitle("Анализируемый сигнал")
 
 % Вычисление периодограммы Кайзера
 Pw=zeros(1,M);
 xp=zeros(1,M);
 w = kaiser(M, 3);
 for p=1:V,
 for n=1:M
 %mur = mur + 1;
 xp(n) = w(n)*x((p-1)*Sdvig+n);
 end
 Pw=Pw+abs(fft(xp)).^2; %fft - БПФ
 muc = muc + M/2 * log2(M);
 adc = adc + M * log2(M);
 adr = adr + M;
 adr = adr + (M-1);
 end
 adr = adr + 2 * adc + 2 * muc;
 mur = 0;
 mur = mur +2*V*M;
 mur = mur + 4 * muc;
 mur = mur + M;
 
 disp(['Mur = ', num2str(mur)]);
 disp(['Adr = ', num2str(adr)]);

 disp(['Muc = ', num2str(muc)]);
 disp(['Adc = ', num2str(adc)]);
 
 
 Pw=Pw/(V*M);
 m=0:M-1;
 f=(m/M)*fd;
 figure(2)
 plot(f, Pw)
 subtitle("Оценка спектра мощности")
 count_mun = xp(n) + P2;
 

